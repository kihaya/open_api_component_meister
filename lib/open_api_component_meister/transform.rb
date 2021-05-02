module OpenApiComponentMeister
  # Transform loaded schema data into hash
  class Transform
    def initialize(model_name:, schema_hash:)
      @data = build!(model_name, schema_hash)
    end

    attr_reader :data

    private

    def build!(model_name, schema_hash)
      properties = schema_hash.keys.map do |key|
        name = schema_hash[key].name
        type = schema_hash[key].type
        {
          name => {
            type: type
          }
        }
      end

      {
        model_name => {
          type: "object",
          properties: properties
        }
      }
    end
  end
end
