class TravianBot
  class Application
    module Navigate
      def to_resources_page(selenium)
        to_page(selenium, 'resources')
      end
      
      def to_village_page(selenium)
        to_page(selenium, 'village')
      end
      
      def to_map_page(selenium)
        to_page(selenium, 'map')
      end
      
      def to_stats_page(selenium)
        to_page(selenium, 'stats')
      end
      
      def to_reports_page(selenium)
        to_page(selenium, 'reports')
      end
      
      private
      def to_page(selenium, target)
        wait = Selenium::WebDriver::Wait.new
        link = selenium.find_element(:xpath, "//ul[@id='navigation']/li[@class='#{target}']/a")
        link.click
      end
    end
  end
end