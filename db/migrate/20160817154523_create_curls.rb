class CreateCurls < ActiveRecord::Migration[5.0]
  def change
    create_table :curls do |t|
      t.string :name
      t.string :method
      t.string :headers
      t.string :url
      t.text :data

      t.timestamps
    end
  end
end
