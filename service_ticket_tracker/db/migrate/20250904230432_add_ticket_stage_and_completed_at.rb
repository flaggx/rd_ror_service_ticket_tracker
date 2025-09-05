class AddTicketStageAndCompletedAt < ActiveRecord::Migration[8.0]
  def up
    create_enum :ticket_stage, %w[
      not_scheduled
      install_removal
      scheduled_today
      scheduled_tomorrow
      parts_needed
      parts_ready
      repair_complete
    ]

    add_column :tickets, :stage, :ticket_stage, default: "not_scheduled", null: false
    add_column :tickets, :completed_at, :datetime
    add_index :tickets, :stage
    add_index :tickets, :completed_at
  end

  def down
    remove_index :tickets, :completed_at
    remove_index :tickets, :stage
    remove_column :tickets, :completed_at
    remove_column :tickets, :stage
    drop_enum :ticket_stage
  end
end