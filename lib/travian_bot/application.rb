require 'selenium-webdriver'
require 'chronic'

require 'travian_bot/application/connection'
require 'travian_bot/application/queue'
require 'travian_bot/application/display'

class TravianBot
  class Application
    class << self
      include Connection
      include Queue
      include Display
      
      # Is executed by the travinbot shell script.      
      def run!(*arguments)
        h1('Welcome to your TravianBot')
        @game = login
        
        h2('Current building queue')
        buildings = building_queue(@game)
        
        if buildings.empty?
          text 'nothing building'
        else
          buildings.each do |building|
            puts building.to_s
          end
        end
        
        h2('Current troop movement')
        troops = troop_movement(@game)
        
        if troops.empty?
          text 'No troops movement'
        else
          troops.each do |troop|
            puts troop.to_s
          end
        end
        
        @game.quit
      
        return 1
      end
      
      private           
      # Get the ending time of a string
      def wait_till(input)
        time = input.to_s.match(/(\d*):(\d*)$/)

        Chronic.parse("today #{time[0]}:#{time[1]}")      
      end
    end
  end
end
