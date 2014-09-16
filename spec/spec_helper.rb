# This file is copied to spec/ when you run 'rails generate rspec:install'
# ENV["RAILS_ENV"] ||= 'test'
# require File.expand_path("../../config/environment", __FILE__)
# require 'rspec/rails'
# require 'rspec/autorun'
#require 'string_extensions'
# require 'active_support/inflector'
# require 'factory_girl_rails'
# require "paperclip/matchers"
require 'byebug'
require 'factory_girl'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/cleaning_cloth'))

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
root_path = File.expand_path("..", __FILE__)
Dir["#{root_path}/support/**/*.rb"].each {|f| require f}
Dir["#{root_path}/factories/**/*.rb"].each {|f| require f}

# if ENV['no_debugger']
#   def debugger
#   end
# else
#   require 'debugger'
# end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  # config.include Paperclip::Shoulda::Matchers

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
  #config.global_fixtures = :all

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  # config.infer_base_class_for_anonymous_controllers = false
  
  #  Configurações do DatabaseCleaner  
  #  incluido por Nardele em 29/06/12 (vide Gem 'database_cleaner')
  # config.before(:suite) do

  #   # debugger
  #   ActiveRecord::Base.establish_connection(:data_import_test)
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)

  #   ActiveRecord::Base.establish_connection(:test)
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)

  # end

  # config.before(:all) do

  #   ActiveRecord::Base.establish_connection(:data_import_test)
  #   DatabaseCleaner.clean_with(:truncation)
  #   ActiveRecord::Base.establish_connection(:test)
  #   DatabaseCleaner.clean_with(:truncation)
  # end

  # config.before(:each) do
  #   ActiveRecord::Base.establish_connection(:data_import_test)
  #   DatabaseCleaner.start
    
  #   ActiveRecord::Base.establish_connection(:test)
  #   DatabaseCleaner.start
  # end

  # config.after(:each) do

  #   ActiveRecord::Base.establish_connection(:data_import_test)
  #   DatabaseCleaner.clean
  #   ActiveRecord::Base.establish_connection(:test)
  #   DatabaseCleaner.clean
  # end

  # config.after(:all) do
  #    DatabaseCleaner.clean
  # end
  #  fim de databasecleaner - Nardele

end

def reload_support
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| load f }
end

def load_factories args=[]
  args.each { |factory|
    FactoryGirl.send('create', *factory)
  }
end

def map_factories args=[]
  args.map { |factory|
    FactoryGirl.send('create', *factory)
  }

  args
end

#require "mocha/setup"
