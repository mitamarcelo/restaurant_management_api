class Restaurant < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :menus, dependent: :destroy
  has_many :plates, dependent: :destroy
end
