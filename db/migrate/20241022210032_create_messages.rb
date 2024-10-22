class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
