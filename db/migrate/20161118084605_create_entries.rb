class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.references :member, null: false     #外部キー
      t.string :title, null: false          #タイトル
      t.text :body                          #本文
      t.datetime :posted_at, null: false    #登校日
      t.string :status, null: false, default: "draft"   #状態
      t.timestamps null: false
    end
    # add_index :entries, :member_id  ⇦もうあるって言われたので、コメントアウト。
    add_foreign_key :entries, :members
  end
end
