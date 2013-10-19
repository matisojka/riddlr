class AddAuthorToSolution < ActiveRecord::Migration
  def change
    add_column :solutions, :author, :string
  end
end
