module Xcrowdin
  class CrowdinClient
    TEMP = Dir.tmpdir()

    def initialize(api_key, project_id, crowdin_path)
      @crowdin = Crowdin::API.new(api_key: api_key, project_id: project_id)
      @crowdin.log = Logger.new $stderr
      @crowdin_path = crowdin_path
    end

    def update_file(file_path)
      @crowdin.update_file(
        files = [
          { :dest => @crowdin_path, :source => file_path }
      ])
    end

    def export
      p "-- start cronwdin exoprt translations"
      @crowdin.export_translations
    end

    def download
      p "-- start cronwdin download translations en"
      @crowdin.download_translation('en', :output => "#{TEMP}/en.zip")
      p "-- start cronwdin download translations zh-TW"
      @crowdin.download_translation('zh-TW', :output => "#{TEMP}/zh-TW.zip")
    end
  end
end
