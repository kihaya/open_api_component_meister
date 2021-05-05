module OpenApiComponentMeister
  class Main
    def initialize(argv)
      @argv = argv
    end

    def run!
      model = @argv[0].constantize.new
      loader = Load.new(model)
      loader.load_schema!

      transformer = Transform.new(load: loader)
      Output.new(transform: transformer).run!
    end

    attr_reader :argv
  end
end
