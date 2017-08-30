module Xcrowdin
  class Client
    TEMP = Dir.tmpdir()

    def initialize(api_key, project_id, crowdin_path, xcode_project, langs)
      @api_key = api_key
      @project_id = project_id
      @crowdin_path = crowdin_path
      @xcode_project = xcode_project
      @langs = langs
      @crowdin = CrowdinClient.new(@api_key, @project_id, @crowdin_path)
    end

    def to_crowdin
      path = "#{TEMP}/xliff"
      lang_code = "en"
      xcode = XcodeClient.new(@xcode_project)
      p "-- start export xliff"
      expoted_path = xcode.export_xliff(lang_code, path)
      p "-- start update_file"
      @crowdin.update_file(expoted_path)
    end

    def to_xcode
      @crowdin.export
      @crowdin.download
      import_to_xcode
    end

    def import_to_xcode
      xcode = XcodeClient.new(@xcode_project)
      @langs.each do |lang|
        p "-- start unzip translations #{lang}"
        unzip_file("#{TEMP}/#{lang}.zip", "#{TEMP}/#{lang}/")
        p "-- start import xliff translations #{lang}"
        xcode.import_xliff("#{TEMP}/#{lang}/#{@crowdin_path}")
      end
    end

    def unzip_file(file, dest)
      FileUtils.mkdir_p(dest)
      Zip::File.open(file) do |zip|
        zip.each do |entry|
          zip.extract(entry, dest + entry.name) { true }
        end
      end
    end
  end
end
