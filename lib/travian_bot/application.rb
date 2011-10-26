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
        
        #current_building_queue
        #current_troop_movements
        #current_avaible_buildings
        
        h2('Custom actions actions')
        text '1 => closest_adventure'
        new_line
        
        command = gets.chomp
        if '1'.eql?(command)
          h2 'Start the closest adventure'
          puts start_closest_adventure(@game) 
        end
        @game.quit
      
        return 1
      end
      
      def current_avaible_buildings
        @game ||= login
        h2 'Avaible buildings'
        buildings = avaible_buildings(@game)
        
        buildings.each do |building|
          text building.to_s
        end  
        new_line
        sleep(3)
      end
       
      def current_building_queue
        @game ||= login
        h2('Current building queue')
        buildings = building_queue(@game)
        
        if buildings.empty?
          warning 'nothing building'
        else
          buildings.each do |building|
            text building.to_s
          end
        end  
        new_line
        sleep(3)
      end
      
      def current_troop_movements
        @game ||= login
        h2('Current troop movement')
        troops = troop_movement(@game)
        
        if troops.empty?
          warning 'No troops movement'
        else
          troops.each do |troop|
            text troop.to_s
          end
        end
        new_line
        sleep(3)
      end
    end
  end
end
