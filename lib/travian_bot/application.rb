require 'selenium-webdriver'
require 'chronic'
require 'yaml'

class TravianBot
  class Application
    class << self
            
      def run!(*arguments)
        login
        building_queue
        close
      
        return 1
      end
      
      private
      
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
      
      def close
        @driver.quit
      end
      
      def building_queue
        # Check if building something
        #begin
          building_pipe = @driver.find_elements(:xpath, "//table[@id='building_contract']/tbody/tr")
          
          building_pipe.each do |entry|
            puts entry.text
          end
        #rescue Selenium::WebDriver::Error::NoSuchElementError
          #puts 'Nothing to build'
        #end
      end
      
      def get_credentials
        credentials = YAML::load(File.open("#{ENV['HOME']}/.travian_bot"))

        [credentials['travian_bot']['url'], credentials['travian_bot']['usr'], credentials['travian_bot']['pwd']]
      end

      def wait_till(input)
        time = input.to_s.match(/(\d*):(\d*)$/)

        Chronic.parse("today #{time[0]}:#{time[1]}")      
      end
    end
  end
end
