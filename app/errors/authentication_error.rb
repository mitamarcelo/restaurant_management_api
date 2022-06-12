module AuthenticationError
  class Unauthorized < StandardError; end
  class CredentialInvalid < StandardError; end
end