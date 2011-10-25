require 'travian_bot/application/time'

class TravianBot
  class Application
    module Hero
      include TravianBot::Application::Navigation
      include TravianBot::Application::Time
      
      def start_closest_adventure(selenium)
        to_hero_quest_page(selenium)
        elements = selenium.find_elements(:xpath, '//div[@class="hero_adventure"]/table/tbody/tr')
        quests = Hash.new
        
        elements.each_with_index do |item, index|
          quests[index] = to_seconds(item.find_element(:class, 'moveTime').text)
        end
        
        shortest_quest = quests.sort{|a,b| a[1] <=> b[1]}.first.first
        elements[shortest_quest].find_element(:class, 'gotoAdventure').click
        
        link = selenium.find_element(:link_text, 'Abenteuer starten')
        link.click
        
        confirm_link = selenium.find_element(:id, 'btn_ok')
        confirm_link.click
      end
    end
  end
end