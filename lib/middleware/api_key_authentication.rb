class ApiKeyAuthentication
  VALID_API_KEYS = ['AABBCCDD']

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    api_key = request.params['api_key']

    if valid_api_key?(api_key)
      # A chave API é válida, continue com a solicitação
      @app.call(env)
    else
      # A chave API é inválida, retorne uma resposta não autorizada
      unauthorized_response
    end
  end

  private

  def valid_api_key?(api_key)
    VALID_API_KEYS.include?(api_key)
  end

  def unauthorized_response
    [401, { 'Content-Type' => 'application/json' }, [{ error: 'Unauthorized' }.to_json]]
  end
end
