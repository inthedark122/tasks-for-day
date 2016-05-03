class Task < ActiveRecord::Base
  belongs_to :users

  validates :name, :description, presence: true
end
