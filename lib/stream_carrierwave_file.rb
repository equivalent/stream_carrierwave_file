require 'forwardable'
require 'mime/types'
require "stream_carrierwave_file/version"
require "stream_carrierwave_file/stream"
require "stream_carrierwave_file/from_file_storage"
require "stream_carrierwave_file/from_fog_storage"

module StreamCarrierwaveFile
  class Configuration
    def ducktype_initialization_enabled
      false
    end
  end

  def self.content_type(file_name)
    MIME::Types.type_for(file_name).first.content_type
  end

  def self.config
    @config ||= Configuration.new
  end
end
