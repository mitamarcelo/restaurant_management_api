module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed
    rescue_from AuthenticationError::Unauthorized, with: :unauthorized
    rescue_from AuthenticationError::CredentialInvalid, with: :credential_invalid
    rescue_from AuthenticationError::AlreadySignedOut, with: :already_signed_out
    rescue_from JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError, JWT::InvalidIssuerError,
                with: :jwt_invalid
  end

  # private

  def record_not_found(err)
    render json: { error: { type: :record_not_found, message: err.to_s } }, status: :not_found
  end

  def record_invalid(err)
    render json: { error: { type: :record_invalid, validations: err.record.errors } }, status: :unprocessable_entity
  end

  def record_not_destroyed(err)
    render json: { error: { type: :record_not_destroyed, message: err.to_s } }, status: :unprocessable_entity
  end

  def unauthorized(err)
    render json: { error: { type: :unauthorized, message: err.to_s } }, status: :unauthorized
  end

  def credential_invalid(err)
    render json: { error: { type: :credential_invalid, message: err.to_s } }, status: :unprocessable_entity
  end

  def jwt_invalid(_err)
    render json: { errors: { type: :jwt_invalid, message: 'Invalid JWT' } }, status: :unauthorized
  end

  def already_signed_out(_err)
    render json: { errors: { type: :already_signed_out, message: 'Already signed out' } }, status: :unauthorized
  end
end
