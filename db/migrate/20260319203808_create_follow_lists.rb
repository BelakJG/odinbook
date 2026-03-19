class CreateFollowLists < ActiveRecord::Migration[8.1]
  def change
    create_table :follow_lists do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :following, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :follow_lists, [ :user_id, :following_id ], unique: true
  end
end
