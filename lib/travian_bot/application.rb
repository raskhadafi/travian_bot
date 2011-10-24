require 'selenium-webdriver'
require 'chronic'

Dir.glob(File.join(File.dirname(__FILE__), '/application/*.rb')).sort.each { |lib| load lib }


class TravianBot
  class Application
    class << self
      include Connection
      include Queue
      include Display
      include Buildings
      
      # Is executed by the travinbot shell script.      
      def run!(*arguments)
        h1('Welcome to your TravianBot')
        @game = login
        
        current_building_queue
        current_troop_movements
        current_avaible_buildings
        
        @game.quit
      
        return 1
      end
      
      private
      def current_avaible_buildings
        h2 'Avaible buildings'
        buildings = avaible_buildings(@game)
        
        buildings.each do |building|
          puts building.to_s
        end  
        new_line
      end
       
      def current_building_queue
        h2('Current building queue')
        buildings = building_queue(@game)
        
        if buildings.empty?
          text 'nothing building'
        else
          buildings.each do |building|
            puts building.to_s
          end
          new_line
        end
      end
      
      def current_troop_movements
        h2('Current troop movement')
        troops = troop_movement(@game)
        
        if troops.empty?
          text 'No troops movement'
        else
          troops.each do |troop|
            puts troop.to_s
          end
          new_line
        end
      end
      
      # Get the ending time of a string
      def wait_till(input)
        time = input.to_s.match(/(\d*):(\d*)$/)

        Chronic.parse("today #{time[0]}:#{time[1]}")      
      end
    end
  end
end
