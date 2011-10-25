require 'yaml'

class TravianBot
  class Application
    module Connection
      # Login in to travian page      
      def login
        @url, user, password = get_credentials
        driver = Selenium::WebDriver.for :firefox
        driver.navigate.to(@url)
        # Get the form fields.
        name_input = driver.find_element(:name, 'name')
        password_input = driver.find_element(:name, 'password')
        login_button = driver.find_element(:id, 's1')
        # Login
        name_input.send_keys(user)
        password_input.send_keys(password)
        login_button.submit
        
        driver
      end
      
      # Load the credentials from ENV['HOME']/.travian_bot
      def get_credentials
        credentials = YAML::load(File.open("#{ENV['HOME']}/.travian_bot"))

        [credentials['travian_bot']['url'], credentials['travian_bot']['usr'], credentials['travian_bot']['pwd']]
      end
    end
  end
end