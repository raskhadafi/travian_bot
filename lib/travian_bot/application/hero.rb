class TravianBot
  class Application
    module Hero
      include TravianBot::Application::Navigation
      
      def start_closest_adventure(selenium)
        to_hero_quest_page(selenium)
        elements = selenium.find_elements(:xpath, '//div[@class="hero_adventure"]/table/tbody/tr')
        elements.each do |element|
          puts element.find_element(:class, 'moveTime').text
        end
        elements.first.find_element(:class, 'gotoAdventure').click
        
        options = selenium.find_elements(:xpath, '//div[@class="options"]/div[@class="option"]')
        options.each do |option|
          link = option.find_element(:tag, 'a')
          
          if link.text == 'Abenteuer starten'
            link.click
          end
        end
      end
    end
  end
end