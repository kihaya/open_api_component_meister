require "active_support"
require "active_record"
require "active_record/connection_adapters/abstract_mysql_adapter"

module OpenApiComponentMeister
  # Convert DB coulumn (ActiveRecord abstract) type to Open API data Type.
  # See: https://swagger.io/docs/specification/data-models/data-types/
  class TypeMapper
    def initialize(type:)
      raise OpenApiComponentMeister::NotSupportedTypeError, "Need to specify any type in #{ar_types.join(' ')}" unless ar_types.include?(type)

      @type = type
      @oas_type = mapped
    end

    attr_reader :type, :oas_type

    private

    def mapped
      case @type
      when :string
        :string
      when :text
        :string
      when :integer
        :integer
      when :float
        :number
      when :decimal
        :number
      when :datetime
        :string
      when :timestamp
        :string
      when :time
        :string
      when :date
        :string
      when :binary
        :string
      when :blob
        :string
      when :boolean
        :boolean
      when :json
        :object
      when :primary_key
        :integer
      end
    end

    def ar_types
      ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::NATIVE_DATABASE_TYPES.keys
    end
  end
end
