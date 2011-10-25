require 'selenium-webdriver'

Dir.glob(File.join(File.dirname(__FILE__), '/application/*.rb')).sort.each { |lib| load lib }

class TravianBot
  class Application
    class << self
      include Connection
      include Queue
      include Display
      include Buildings
      include Hero
      
      # Is executed by the travinbot shell script.      
      def run!(*arguments)
        h1('Welcome to your TravianBot')
        @game = login
        
        h2('Your avaible actions')
        #command = gets
        #self.send(command)
        current_building_queue
        current_troop_movements
        current_avaible_buildings
        start_closest_adventure @game
        @game.quit
      
        return 1
      end
      
      def current_avaible_buildings
        @game ||= login
        h2 'Avaible buildings'
        buildings = avaible_buildings(@game)
        
        buildings.each do |building|
          puts building.to_s
        end  
        new_line
      end
       
      def current_building_queue
        @game ||= login
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
        @game ||= login
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
    end
  end
end
