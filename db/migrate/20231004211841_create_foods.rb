class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.datetime :imported_t
      t.string :status

      t.timestamps
    end
  end
end
