require 'travian_bot/application/navigation'

class TravianBot
  class Application 
    module Buildings
      include TravianBot::Application::Navigation
            
      def avaible_buildings(selenium)
        begin
          elements = selenium.find_elements(:xpath, '//map[@id="rx"]/area')
          resources = elements.inject([]) do |out, element|
            out << element.attribute('alt')
            
            out
          end
        rescue Selenium::WebDriver::Error::NoSuchElementError
          resources = []
        end
        
        to_village_page(selenium)
        show_building_level(selenium)
        
        begin
          elements = selenium.find_elements(:xpath, '//div[@id="village_map"]/map/area')
          buildings = elements.inject([]) do |out, element|
            out << element.attribute('alt')
            
            out
          end
        rescue Selenium::WebDriver::Error::NoSuchElementError
          buildings = []
        end
        
        resources + buildings
      end
      
      private
      def show_building_level(selenium)
        link = selenium.find_element(:xpath, '//img[@id="lswitch"]')
        link.click
      end
    end
  end
end
