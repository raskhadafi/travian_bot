class TravianBot
  class Application
    module Navigation
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
      
      def to_hero_quest_page(selenium)
        selenium.navigate.to @url + "hero_adventure.php"
      end
      
      private
      def to_page(selenium, target)
        link = selenium.find_element(:xpath, "//ul[@id='navigation']/li[@class='#{target}']/a")
        link.click
      end
    end
  end
end