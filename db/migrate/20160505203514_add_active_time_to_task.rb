class AddActiveTimeToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :active_time, :integer, default: 0
  end
end
