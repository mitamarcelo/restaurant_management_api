class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_and_belongs_to_many :restaurants

  def jwt_payload
    { jti:, user: { name:, email: }, exp: 1.days.from_now.to_i }
  end
end
