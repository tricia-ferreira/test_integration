class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests do |t|
      t.integer :test_id
      t.string :first_name

      t.timestamps
    end
  end
end
