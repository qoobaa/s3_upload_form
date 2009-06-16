require 'base64'
require 'openssl'
require 'digest/sha1'

require 'd2s3/configuration'
require 'd2s3/view_helpers'

ActionView::Base.send(:include, D2s3::ViewHelpers) if defined?(ActionView::Base)
