class AddNotesToCurls < ActiveRecord::Migration[5.0]
  def change
    add_column :curls, :notes, :text
  end
end
