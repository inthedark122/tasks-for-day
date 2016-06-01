json.set! :tasks do
  json.array! @tasks do |task|
    json.partial! 'api/v1/tasks/full', task: task

    json.set! :user do
      unless task.user.blank?
        json.partial! 'api/v1/users/short', user: task.user
      end
    end
  end

end