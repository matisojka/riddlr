class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.references :quiz, index: true
      t.text :code
      t.boolean :passed
      t.json :expectations

      t.timestamps
    end
  end
end
