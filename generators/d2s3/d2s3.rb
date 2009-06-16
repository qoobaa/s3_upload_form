require 'rbconfig'

class D2S3Generator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory "config"
      m.directory "config/initializers"
      m.file      "initializers/d2s3.rb", "config/initializers/d2s3.rb"
    end
  end

  protected

  def banner
    "Usage: #{$0} d2s3"
  end
end
