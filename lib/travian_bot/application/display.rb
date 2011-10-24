class TravianBot
  class Application
    module Display
      def h1(text)
        puts ' '
        puts "#{text}"
        puts "=" * text.length
        puts ' '
        puts ' '
      end
      
      def h2(text)
        puts "#{text}"
        puts "-" * text.length
        puts ' '
      end
      
      def text(text)
        puts text
        puts ' '
      end
      
      def new_line
        puts ' '
      end
    end
  end
end