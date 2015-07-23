$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'stream_carrierwave_file'
require 'fog'
require 'carrierwave'
require 'pathname'

module TestPaths
  def self.fixtures
    Pathname
      .new(File.dirname(__FILE__))
      .join('fixtures')
  end
end

class LocalFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    TestPaths.fixtures
  end

  def stream_fallback
    TestPaths.fixtures.join('default.gif')
  end
end

class FogFileUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    '/bucket-upload/'
  end

  def stream_fallback
    TestPaths.fixtures.join('default.gif')
  end
end

