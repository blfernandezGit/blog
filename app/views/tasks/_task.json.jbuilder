json.extract! task, :id, :name, :body, :task_date, :category_id, :created_at, :updated_at
json.url task_url(task, format: :json)
