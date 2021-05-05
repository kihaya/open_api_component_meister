module OpenApiComponentMeister
  class Main
    def initialize(argv)
      @argv = argv
    end

    def run!
      load_app! if ENV["RAILS_ENV"].present?

      model = @argv[0].constantize.new
      loader = Load.new(model)
      loader.load_schema!

      transformer = Transform.new(load: loader)
      Output.new(transform: transformer).run!
    end

    attr_reader :argv

    private

    def load_app!
      require 'bundler'
      require 'rake/dsl_definition'
      require 'rake'

      Bundler.setup

      load './Rakefile' if File.exist?('./Rakefile')
      Rake::Task[:environment].invoke

      ::Rails::Application.send(:subclasses).first.eager_load!
    end
  end
end
