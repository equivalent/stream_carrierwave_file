module StreamCarrierwaveFile
  class Stream
    class FromFileStorage
      extend Forwardable

      attr_reader :stream
      def_delegator :stream, :field

      def initialize(stream)
        @stream = stream
      end

      def source
        field.path
      end

      def send
        if field.present? && file_is_physically_present?
          stream.controller.send_file source,
            type: StreamCarrierwaveFile.content_type(source),
            disposition: 'inline'
        else
          stream.send_fallback
        end
      end

      # if you manually deleate file on a disc, CarrierWave still
      # think that file exist. Stream would fail due to this
      def file_is_physically_present?
        field.file.size > 0
      end
    end
  end
end
