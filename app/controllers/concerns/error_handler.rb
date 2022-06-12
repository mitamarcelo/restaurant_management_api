module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed
    rescue_from AuthenticationError::Unauthorized, with: :unauthorized
    rescue_from AuthenticationError::CredentialInvalid, with: :credential_invalid
    rescue_from JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError, with: :jwt_invalid
  end

  # private

  def record_not_found(e)
    render json: { error: { type: :record_not_found, message: e.to_s } }, status: :not_found
  end

  def record_invalid(e)
    render json: { error: { type: :record_invalid, validations: e.record.errors } }, status: :unprocessable_entity
  end

  def record_not_destroyed(e)
    render json: { error: { type: :record_not_destroyed, message: e.to_s } }, status: :unprocessable_entity
  end

  def unauthorized(e)
    render json: { error: { type: :unauthorized, message: e.to_s } }, status: :unauthorized
  end

  def credential_invalid(e)
    render json: { error: { type: :credential_invalid, message: e.to_s } }, status: :unprocessable_entity
  end

  def jwt_invalid(e)
    render json: { errors: { type: :jwt_invalid, message: 'Invalid JWT' } }, status: :unauthorized
  end
end
