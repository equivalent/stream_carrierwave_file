require 'spec_helper'

RSpec.describe StreamCarrierwaveFile::Stream do
  let(:controller) { double('controller') }
  let(:stream) { described_class.new(controller: controller, uploader: uploader_instance) }



  context 'from remote storage' do
    before :all do
      Fog.mock!
      Fog.credentials_path = TestPaths.fixtures.join('dummy_fog_credentials.yml')
      connection = Fog::Storage.new(:provider => 'AWS')
      connection.directories.create(:key => 'my_bucket')
    end

    let(:uploader_instance) {
      FogFileUploader.new
        .tap { |u| u.retrieve_from_store!('test.png') }
    }

    it 'should send_file with image local absolute path' do

      expect(controller)
        .to receive(:send_file)
        .with(uploader_instance.path, :type=>"image/png", :disposition=>"inline")
        .and_return('foo')

      expect(stream.send).to eq 'foo'
    end

  end




  #let(:file) { File.open 'spec/fixtures/test.png' }
  #let(:controller) { double('controller') }
  #let(:stream) { described_class.new(controller: controller, uploader_field: uploader_field) }

  #let(:resource_without_file) { double }
  #let(:resource_with_file) do
    #tld = create :tld
    #tld.website_logo_image = file
    #tld.save
    #tld
  #end

  #context 'from remote storage' do 
    #before :all do
      #Fog.mock!
      #Fog.credentials_path = Rails.root.join('spec/support/dummy_fog_credentials.yml')
      #connection = Fog::Storage.new(:provider => 'AWS')
      #connection.directories.create(:key => 'my_bucket')

      #BrandingUploader.storage :fog
    #end

    #after :all do
      #BrandingUploader.storage :file
    #end

    #let(:resource_with_file) do 
      #tld = create :tld
      #tld.website_logo_image = file
      #tld
    #end

    #context 'when field uploader with existing file' do
      #let(:uploader_field) { resource_with_file.website_logo_image }

      #it "spec_name" do
        #expect_any_instance_of(StreamCarrierwaveFile::FromFogStorage).
          #to receive(:open).
          #with(uploader_field.url).
          #and_return(double :data, read: 'xxx')

        #resource_with_file.website_logo_image

          #expect(controller).
            #to receive(:send_data).
            #with('xxx', :type=>"image/jpeg", :disposition=>"inline").
            #and_return('bar')

        #expect(stream.send).to eq 'bar'
      #end
    #end

    #context 'when field uploader without existing file' do
      #let(:uploader_field) { resource_without_file.website_logo_image }

      #it 'should send_file with default image path' do
        #expect_any_instance_of(StreamCarrierwaveFile::FromFogStorage).
          #to receive(:open).
          #with("/assets/stream/website_logo_image.gif").
          #and_return(double :data, read: 'xxx')

        #expect(controller).
          #to receive(:send_data).
          #with('xxx', :type=>"image/gif", :disposition=>"inline").
          #and_return('foo')

        #expect(stream.send).to eq 'foo'
      #end
    #end
  #end
end
