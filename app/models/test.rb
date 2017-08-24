class Test < ApplicationRecord
  validates :test_id, presence: true
  validates :first_name, presence: true
end
