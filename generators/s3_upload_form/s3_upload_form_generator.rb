require 'rbconfig'

class S3UploadFormGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory "config"
      m.directory "config/initializers"
      m.file      "initializers/s3_upload_form.rb", "config/initializers/s3_upload_form.rb"
    end
  end

  protected

  def banner
    "Usage: #{$0} s3_upload_form"
  end
end
