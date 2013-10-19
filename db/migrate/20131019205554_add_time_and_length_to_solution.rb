class AddTimeAndLengthToSolution < ActiveRecord::Migration
  def change
    add_column :solutions, :time, :float
    add_column :solutions, :code_length, :integer
  end
end
