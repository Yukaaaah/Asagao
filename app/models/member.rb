# ActiveRecord::Baseクラスを継承していないのはなぜ。
class Member < ApplicationRecord
# ミックスイン
    include EmailAddressChecker
# モデル関連づけ
    has_many :entries, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :voted_entries, through: :votes, source: :entry
    has_one :image, class_name: "MemberImage", dependent: :destroy
    accepts_nested_attributes_for :image, allow_destroy: true

#　バリデーション
    # 背番号
    validates :number,
     presence: true,
     numericality: { only_integer: true,
                     greater_than: 0,
                     less_than: 100,
                     allow_blank: true},
    uniqueness: true
    # ユーザ名
    validates :name,
     presence: true,
     format: { with: /\A[A-Za-z]\w*\z/,
               allow_blank: true,
               message: :invalid_member_name },
     length: { minimum: 2,
               maximum: 20,
               allow_blank: true},
    uniqueness: { case_sensitive: false }
    # 氏名
    validates :full_name,
     length: { maximum: 20}
    # メールアドレス
    validate :check_email
    # パスワード
    validates :password,
     presence: { on: :create },
     confirmation: { allow_balnk: true}

    attr_accessor :password, :password_confirmation

    def password=(val)
        if val.present?
            self.hashed_password = BCrypt::Password.create(val)
        end
        @password = val
    end

    def votable_for?(entry)
        entry && entry.author != self && !votes.exists?(entry_id: entry.id)
    end

    private
    def check_email
        if email.present?
            errors.add(:email, :invalid) unless well_formed_as_email_address(email)
        end
    end

# 検索機能
    class << self
        def search(query)
            rel = order("number")
            if query.present?
                rel = rel.where("name LIKE ? OR full_name LIKE ?",
                "%#{query}","%#{query}",)
            end
            rel
        end

        def authenticate(name,password)
            member = find_by(name: name)
            if member && member.hashed_password.present? &&
                BCrypt::Password.new(member.hashed_password) == password
                member
            else
                nil
            end
        end
end
end
