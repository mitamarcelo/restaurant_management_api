class UsersController < ApplicationController
  before_action :authenticate_user!

  def logout
    current_user.update_column(:jti, SecureRandom.uuid)
    head :no_content
  rescue e
    head :no_content
  end
end
