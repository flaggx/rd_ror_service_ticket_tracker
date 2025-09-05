class CreateTicketEnums < ActiveRecord::Migration[8.0]
  def up
    create_enum :priority, %w[low medium high]
    create_enum :work_type, %w[install removal]
  end

  def down
    drop_enum :work_type
    drop_enum :priority
  end
end
