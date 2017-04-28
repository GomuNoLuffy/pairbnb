class AddCategoryToTag < ActiveRecord::Migration[5.0]
  def change
  	add_column :tags, :category, :integer
  end
end
