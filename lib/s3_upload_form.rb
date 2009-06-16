require 'base64'
require 'openssl'
require 'digest/sha1'

require 's3_upload_form/configuration'
require 's3_upload_form/helpers'

ActionView::Base.send(:include, S3UploadForm::Helpers) if defined?(ActionView::Base)
