module Authentication
  extend ActiveSupport::Concern

  def current_user
    @current_user
  end

  def authenticate_user!
    jwt_payload = process_authorization_token

    raise AuthenticationError::Unauthorized, 'Access Token: User identifier missing' unless jwt_payload['uid']

    @current_user = User.find_by_jti(jwt_payload['uid'])
    raise AuthenticationError::Unauthorized, 'Access Token: User identifier invalid' unless @current_user.present?
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end

  def user_registration_params
    params.require(:registration).permit(:email, :password, :name)
  end

  def process_authorization_token
    token = request.headers['Authorization']
    token ||= request.query_parameters['access_token']
    raise AuthenticationError::Unauthorized, 'Authorization not provided' unless token.present?

    jwt = token.split(' ').last
    JWT.decode(jwt, ENV['DEVISE_SECRET_KEY']).first
  end

  def set_authorization_header(user)
    response.set_header('Authorization', "Bearer #{generate_access_token(user)}")
  end

  def generate_access_token(user)
    JWT.encode({ uid: user.jti, user: { name: user.name, email: user.email }, exp: 1.days.from_now.to_i },
               ENV['DEVISE_SECRET_KEY'])
  end
end
