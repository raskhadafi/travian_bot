require 'selenium-webdriver'
require 'travian_bot/tools'

class TravianBot
  class Application
    class << self
      include Tools
            
      def run!(*arguments)
        url, user, password = get_credentials
        driver = Selenium::WebDriver.for :firefox
        driver.navigate.to(url)

        # Login
        name_input = driver.find_element(:name, 'name')
        password_input = driver.find_element(:name, 'password')
        login_button = driver.find_element(:id, 's1')

        name_input.send_keys(user)
        password_input.send_keys(password)
        login_button.submit

        # Check if building something
        #begin
          building_pipe = driver.find_element(:id, 'building_contract')
          building_time = driver.find_element(:class, 'buildingTime').text
          puts wait_till(building_time)
        #rescue
          #puts 'Nothing to build'
        #end

        driver.quit
      
        return 1
      end
    end
  end
end
