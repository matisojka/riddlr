class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :title
      t.text :description
      t.string :goal
      t.text :private_environment
      t.text :public_environment
      t.json :expectations
      t.text :solution
      t.json :hints
      t.string :difficulty
      t.json :tags
      t.string :author
      t.boolean :private

      t.timestamps
    end
  end
end
