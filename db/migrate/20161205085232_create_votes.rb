class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
        t.references :entry, null: false #外部キー
        t.references :member, null: false #外部キー
        t.timestamps null: false
    end
    # add_index :votes, :entry_id
    # add_index :votes, :member_id
  end
end
