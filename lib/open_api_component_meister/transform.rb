module OpenApiComponentMeister
  # Transform loaded schema data into hash
  class Transform
    def initialize(load:)
      @load = load
      @data = build!
    end

    attr_reader :load, :data

    private

    def build!
      properties = schema_hash.keys.map do |key|
        name = schema_hash[key].name
        type = TypeMapper.new(type: schema_hash[key].type).oas_type
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

    def model_name
      @load.model_name
    end

    def schema_hash
      @load.schema_hash
    end
  end
end
