class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true
      t.string :name
      t.string :description
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps null: false
    end
  end
end
