module StreamCarrierwaveFile
  class Stream
    MustBeCarrierWaveUploaderInstance = Class.new(StandardError)

    attr_reader :controller, :field

    def initialize(options)
      @controller = options
        .fetch(:controller) { raise ArgumentError, 'missing :controller' }
      @field      = options
        .fetch(:uploader) { raise ArgumentError, 'missing :uploader' }

      typecheck
    end

    def typecheck
      if !StreamCarrierwaveFile.config.ducktype_initialization_enabled && !field.is_a?(CarrierWave::Uploader::Base)
        raise MustBeCarrierWaveUploaderInstance
      end
    end

    def stream_instance
      case field.send(:storage).class.name
      when 'CarrierWave::Storage::File'
        FromFileStorage.new(self)
      when 'CarrierWave::Storage::Fog'
        FromFogStorage.new(self)
      else
        raise 'unknown storage type'
      end
    end

    def send
      stream_instance.send
    end

    def send_fallback
      controller.send_file field.stream_fallback,
        type: StreamCarrierwaveFile.content_type(field.stream_fallback.to_s),
        disposition: 'inline'
    end
  end
end
