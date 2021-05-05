require "yaml"

module OpenApiComponentMeister
  class Output
    def initialize(transform:)
      @transform = transform
    end

    def run!
      puts @transform.data.to_yaml
    end

    attr_reader :transform
  end
end
