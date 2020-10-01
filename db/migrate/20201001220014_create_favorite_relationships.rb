class CreateFavoriteRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_relationships do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
    add_index :favorite_relationships, :user_id
    add_index :favorite_relationships, :micropost_id
    add_index :favorite_relationships, [:user_id, :micropost_id], unique: true
  end
end
