json.extract! task, :id, :name, :body, :task_date, :category_id, :created_at, :updated_at
byebug
json.url category_url(task.category, format: :json)
