class AddDeadlineToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline, :date, null: false, default: "Wed, 11 Jan 2023"
    change_column_default :tasks, :deadline, nil
  end
end
