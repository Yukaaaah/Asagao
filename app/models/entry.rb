class Entry < ApplicationRecord
    belongs_to :author, class_name: "Member", foreign_key: "member_id"
    has_many :votes, dependent: :destroy
    has_many :voters, through: :votes, source: :member
        
# 状態の文字列の選択肢は、カッコの3つ
    STATUS_VALUES = %w(draft member_only public)

    validates :title, presence: true, length:{ maximum:200 }
    validates :body, :posted_at, presence: true
    validates :status, inclusion: {in: STATUS_VALUES}

# p.426 ブログ記事絞り込みスコープ
    scope :common, ->{ where(status: "public")}
    scope :published, ->{ where("status <> ?", "draft")}
    scope :full, ->(member) { where("status <> ? OR member_id = ?", "draft", member.id )}
    scope :readable_for, ->(member) { member ? full(member) : common }

# ビュー用のメソッド
    class << self
        def status_text(status)
            I18n.t("activerecord.attributes.entry.status_#{status}")
        end
        # ステータスの内容と日本語を配列に。プルダウンリストの表示のため
        def status_options
            STATUS_VALUES.map{|status| [status_text(status), status]}
        end

        def sidebar_entries(member, num = 5)
            readable_for(member).order(posted_at: :desc).limit(num)
        end
    end
end
