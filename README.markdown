# s3_upload_form

### Usage
  <% form_tag s3_bucket_url, :multipart => true do -%>
    <%= s3_signature_tag :key => "uploads",
                         :redirect => image_processing_url,
                         :acl => "public-read",
                         :max_filesize => 0..5.megabytes,
                         :submit => submit_tag("Upload!") %>
    <%= label_tag :file, "File" %>
    <br/>
    <%= file_field_tag :file %>
    <br/>
    <%= submit_tag "Upload" %>
  <% end -%>

Remember to turn off the request forgery protection in the controller:

  class UploadsController < ApplicationController
    self.allow_forgery_protection = false

    def new
      # ...
    end
  end

### Configuration

To configure s3_upload_form use s3_upload_form generator...
    ./script/generate s3_upload_form

... and edit the generated initializer file s3_upload_form.rb.

### Jakub Kuźma, 2009

The gem is based on D2S3 plugin by Matthew Williams.
