module OpenApiComponentMeister
  # Load ActiveRecord model and store name/type hash.
  class Load
    def initialize(ar_model)
      @ar_model = ar_model
      @model_name = ar_model.class.name
      @schema_hash = nil
    end

    def load_schema!
      @schema_hash = @ar_model.class.columns_hash
    end

    attr_reader :ar_model, :model_name, :schema_hash
  end
end
