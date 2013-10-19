class AddPermalinkToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :permalink, :string
    add_index :quizzes, :permalink
  end
end
