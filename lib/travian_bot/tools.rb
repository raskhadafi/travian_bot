require 'chronic'
require 'yaml'

class TravianBot
  module Tools
    def get_credentials
      credentials = YAML::load(File.open("#{ENV['HOME']}/.travian_bot"))
      
      [credentials['travian_bot']['url'], credentials['travian_bot']['usr'], credentials['travian_bot']['pwd']]
    end
    
    def wait_till(input)
      time = input.to_s.match(/(\d*):(\d*)$/)
      
      Chronic.parse("today #{time[0]}:#{time[1]}")      
    end
  end
end