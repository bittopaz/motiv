class CreateGoals < ActiveRecord::Migration[8.1]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :motivation
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
  end
end
