require 'selenium-webdriver'
require 'chronic'
require 'yaml'

class TravianBot
  class Application
    class << self
            
      def run!(*arguments)
        login
        building_queue
        troop_movement
        close
      
        return 1
      end
      
      # Login in to travian page      
      def login
        url, user, password = get_credentials
        @driver = Selenium::WebDriver.for :firefox
        @driver.navigate.to(url)
        name_input = @driver.find_element(:name, 'name')
        password_input = @driver.find_element(:name, 'password')
        login_button = @driver.find_element(:id, 's1')

        name_input.send_keys(user)
        password_input.send_keys(password)
        login_button.submit
      end
      
      # Close the selenium connection
      def close
        @driver.quit
      end
      
      # Check if building something
      def building_queue
        begin
          building_pipe = @driver.find_elements(:xpath, "//table[@id='building_contract']/tbody/tr")
          
          building_pipe.each do |entry|
            puts entry.text
          end
        rescue Selenium::WebDriver::Error::NoSuchElementError
          puts 'Nothing in building queue'
        end
      end
      
      # Show the troop movement.
      def troop_movement
        begin
          troop_movement = @driver.find_elements(:xpath, "//table[@id='movements']/tbody/tr")
          
          troop_movement.each do |movement|
            puts movement.text
          end
        rescue   Selenium::WebDriver::Error::NoSuchElementError
          puts 'No troop movement'
        end 
      end
      
      private
      
      # Load the credentials from ENV['HOME']/.travian_bot
      def get_credentials
        credentials = YAML::load(File.open("#{ENV['HOME']}/.travian_bot"))

        [credentials['travian_bot']['url'], credentials['travian_bot']['usr'], credentials['travian_bot']['pwd']]
      end
            
      # Get the ending time of a string
      def wait_till(input)
        time = input.to_s.match(/(\d*):(\d*)$/)

        Chronic.parse("today #{time[0]}:#{time[1]}")      
      end
    end
  end
end
