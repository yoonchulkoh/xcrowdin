module Xcrowdin
  class XcodeClient
    def initialize(project_path)
      @project_path = project_path
    end

    def export_xliff(lang_code, path)
      command = "xcodebuild -exportLocalizations -exportLanguage #{lang_code} -localizationPath #{path} -project #{@project_path}"

      res = IO.popen(command, :err => [:child, :out])
      res.each_line do |text|
        raise(text) if text.include?("xcodebuild: error")
      end
      return "#{path}/#{lang_code}.xliff"
    end

    def import_xliff(path)
      command = "xcodebuild -importLocalizations -localizationPath #{path}  -project #{@project_path}"

      res = IO.popen(command, :err => [:child, :out])
      res.each_line do |text|
        raise(text) if text.include?("xcodebuild: error")
      end
    end
  end
end
