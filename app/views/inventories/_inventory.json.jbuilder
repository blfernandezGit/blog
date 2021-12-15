json.extract! inventory, :id, :stock_code, :stock_name, :quantity, :user_id, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
