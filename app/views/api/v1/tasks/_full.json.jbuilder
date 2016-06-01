task ||= @task

json.(task, :id, :name, :description, :started_at, :finished_at, :active_time)