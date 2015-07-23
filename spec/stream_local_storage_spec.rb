require 'spec_helper'

RSpec.describe StreamCarrierwaveFile::Stream do
  let(:controller) { double('controller') }
  let(:stream) { described_class.new(controller: controller, uploader: uploader_instance) }

  context 'from local storage' do
    context 'when field uploader with existing file' do
      let(:uploader_instance) {
        LocalFileUploader.new
          .tap { |u| u.retrieve_from_store!('test.png') }
      }

      it 'should send_file with image local absolute path' do
        expect(uploader_instance.path).to match(/#{TestPaths.fixtures.to_s}/) #sanity check

        expect(controller)
          .to receive(:send_file)
          .with(uploader_instance.path, :type=>"image/png", :disposition=>"inline")
          .and_return('foo')

        expect(stream.send).to eq 'foo'
      end
    end
  end

  context 'when field uploader without existing file' do
    let(:uploader_instance) { LocalFileUploader.new }

    it 'should send_file with default image path' do
      expect(controller)
        .to receive(:send_file)
        .with(TestPaths.fixtures.join("default.gif"), :type=>"image/gif", :disposition=>"inline")
        .and_return('foo')

      expect(stream.send).to eq 'foo'
    end
  end
end
