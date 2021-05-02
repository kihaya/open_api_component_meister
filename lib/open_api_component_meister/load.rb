module OpenApiComponentMeister
  # Load ActiveRecord model and store name/type hash.
  class Load
    def initialize(ar_model)
      @ar_model = ar_model
      @schema_hash = nil
    end

    def load_schema!
      @schema_hash = ar.class.column_hash
    end

    attr_reader :ar_model, :schema_hash
  end
end
