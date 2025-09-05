class BackfillNullTicketStages < ActiveRecord::Migration[8.0]
  def up
    execute "UPDATE tickets SET stage = 'not_scheduled' WHERE stage IS NULL"
  end

  def down
    # no-op
  end
end