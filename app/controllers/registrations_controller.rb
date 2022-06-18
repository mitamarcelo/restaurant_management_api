class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    @user = User.new(user_registration_params)
    raise AuthenticationError::CredentialInvalid, "Error creating account: #{@user.errors.message}" unless @user.save!

    set_authorization_header(@user)
    head :no_content
  end
end
