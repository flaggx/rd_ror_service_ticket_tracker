json.extract! ticket_image, :id, :url, :ticket_id, :created_at, :updated_at
json.url ticket_image_url(ticket_image, format: :json)
