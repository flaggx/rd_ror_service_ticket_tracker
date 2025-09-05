json.extract! ticket, :id, :account_name, :city, :contact_person, :contact_info, :lease, :under_warranty, :machine_model_or_type, :issue_description, :requesting_tech_name, :assigned_to, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
