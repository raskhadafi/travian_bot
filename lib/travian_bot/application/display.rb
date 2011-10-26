require 'term/ansicolor'

class String
  include Term::ANSIColor
end

class TravianBot
  class Application
    module Display
      def h1(text)
        puts ' '
        puts "#{text}".red
        puts "=".red * text.length
        puts ' '
      end
      
      def h2(text)
        puts "#{text}".yellow
        puts "-".yellow * text.length
      end
      
      def text(text)
        puts text.to_s.green
      end
      
      def warning(text)
        puts text.to_s.red
      end
      
      def new_line
        puts ' '
      end
    end
  end
end