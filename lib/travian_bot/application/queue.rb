require 'selenium-webdriver'

class TravianBot
  class Application
    module Queue
      # Check if building something
      def building_queue(selenium)        
        begin
          building_pipe = selenium.find_elements(:xpath, "//table[@id='building_contract']/tbody/tr")
          
          building_pipe.inject([]) do |out, entry|
            out << entry.text
            
            out
          end
        rescue Selenium::WebDriver::Error::NoSuchElementError
          []
        end
      end
      
      # Show the troop movement.
      def troop_movement(selenium)
        begin
          troop_movement = selenium.find_elements(:xpath, "//table[@id='movements']/tbody/tr")
          
          troop_movement.inject([]) do |out, movement|
            out << movement.text
            
            out
          end
        rescue   Selenium::WebDriver::Error::NoSuchElementError
          []
        end
      end
    end
  end
end