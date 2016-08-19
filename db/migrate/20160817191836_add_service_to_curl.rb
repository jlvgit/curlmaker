class AddServiceToCurl < ActiveRecord::Migration[5.0]
  def change
    add_column :curls, :service, :string
  end
end
