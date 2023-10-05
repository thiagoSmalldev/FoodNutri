class AddFieldCodeToFood < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :code, :integer
  end
end
