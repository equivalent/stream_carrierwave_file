module StreamCarrierwaveFile
  class Stream
    class FromFogStorage
      attr_reader :stream

      def initialize(stream)
        @stream = stream
      end

      def source
        stream.field.url
      end

      def content_type_source
        stream.field.path || stream.field.url
      end

      def send
        begin
          require 'pry'; binding.pry
          stream.controller.send_data open(source).read,
            type: StreamCarrierwaveFile.content_type(content_type_source),
            disposition: 'inline'
        rescue Errno::ENOENT
          stream.send_fallback
        end
      end
    end
  end
end
