require 'webmock'

# RSpec 1.x and 2.x compatibility
if defined?(RSpec)
  RSPEC_NAMESPACE = RSPEC_CONFIGURER = RSpec
elsif defined?(Spec)
  RSPEC_NAMESPACE = Spec
  RSPEC_CONFIGURER = Spec::Runner
else  
  begin
    require 'rspec'
    RSPEC_NAMESPACE = RSPEC_CONFIGURER = RSpec
  rescue LoadError
    require 'spec'
    RSPEC_NAMESPACE = Spec
    RSPEC_CONFIGURER = Spec::Runner
  end
end

require 'webmock/rspec/matchers'
  
RSPEC_CONFIGURER.configure { |config|

  config.include WebMock::Matchers

  config.before :each do
    WebMock.reset!
  end
}

WebMock::AssertionFailure.error_class = RSPEC_NAMESPACE::Expectations::ExpectationNotMetError
