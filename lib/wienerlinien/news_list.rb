module Wienerlinien
  # NewsList
  class NewsList
    def initialize(connection)
      @connection = connection
    end

    def get(params)
      response = perform_get(params)
      RecursiveOpenStruct.new(
        response.body['data'],
        recurse_over_arrays: true)
    end

    def perform_get(params = {})
      response = @connection.get do |req|
        req.params = params
        req.url '/ogd_realtime/newsList'
        req.headers['Content-Type'] = 'application/json'
      end

      unless response.success?
        # XXX: proper error handling
        puts JSON.parse(response.body)
      end

      response
    end
  end # NewsList
end # Wienerlinien
