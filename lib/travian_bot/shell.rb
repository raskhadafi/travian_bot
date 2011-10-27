require 'bombshell'
require 'travian_bot/application'

class TravianBot
 class Shell < Bombshell::Environment
   include Bombshell::Shell
   include TravianBot::Application::Connection
   include TravianBot::Application::Hero

   prompt_with 'travianbot'
   
   having_launched do
    @browser = login
    init # binding is on your shell *class*
   end
   
   def start_quest
     start_closest_adventure @browser
   end

   def help
     h1 'Help'
   end
   
   private
   include TravianBot::Application::Display
 end
end