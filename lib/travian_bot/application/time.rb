require 'chronic_duration'

class TravianBot
  class Application
    module Time
      def to_seconds(input)
        ChronicDuration.parse(input)
      end
    end
  end
end