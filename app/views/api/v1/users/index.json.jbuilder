json.set! :users do
  json.array! @users do |user|
    json.partial! 'api/v1/users/short', user: user
  end
end