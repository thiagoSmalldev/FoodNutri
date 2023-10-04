class AddFieldsToFood < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :url, :string
    add_column :foods, :creator, :string
    add_column :foods, :created_t, :datetime
    add_column :foods, :last_modified_t, :datetime
    add_column :foods, :product_name, :string
    add_column :foods, :quantity, :string
    add_column :foods, :brands, :string
    add_column :foods, :categories, :string
    add_column :foods, :labels, :string
    add_column :foods, :cities, :string
    add_column :foods, :purchase_places, :string
    add_column :foods, :stores, :string
    add_column :foods, :ingredients_text, :text
    add_column :foods, :traces, :string
    add_column :foods, :serving_size, :string
    add_column :foods, :serving_quantity, :float
    add_column :foods, :nutriscore_score, :integer
    add_column :foods, :nutriscore_grade, :string
    add_column :foods, :main_category, :string
    add_column :foods, :image_url, :string
  end
end
