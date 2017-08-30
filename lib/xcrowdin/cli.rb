require 'thor'

module Xcrowdin
  class CLI < Thor

    desc "to_crowdin", "Export from Xcode and upload to Crowdin."
    option :api_key, :required => true
    option :project_id, :required => true
    option :crowdin_path, :required => true
    option :xcode_project, :required => true
    option :langs, :required => true, :type => :array
    def to_crowdin
      client = Xcrowdin::Client.new(
        options[:api_key],
        options[:project_id],
        options[:crowdin_path],
        options[:xcode_project],
        options[:langs]
      )
      client.to_crowdin
    end

    desc "to_xcode", "Export from Crowdin and import to XCode."
    option :api_key, :required => true
    option :project_id, :required => true
    option :crowdin_path, :required => true
    option :xcode_project, :required => true
    option :langs, :required => true, :type => :array
    def to_xcode
      client = Xcrowdin::Client.new(
        options[:api_key],
        options[:project_id],
        options[:crowdin_path],
        options[:xcode_project],
        options[:langs]
      )
      client.to_xcode
    end

  end
end
