class SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # skip_before_action :verify_signed_out_user
  respond_to :json

  # POST /sign_in
  def create
    @user = authenticate_credentials!(
      user_params[:email],
      user_params[:password]
    )
    set_authorization_header(@user)
    render 'users/show'
  end

  private

  def authenticate_credentials!(email, password)
    user = User.find_by_email(email)
    if user.nil? || !user.valid_password?(password)
      raise AuthenticationError::CredentialInvalid,
            'Email or password invalid'
    end

    user
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def respond_to_on_destroy
    head :no_content
  end
end
