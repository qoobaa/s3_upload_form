# *s3_upload_form*

### Usage
    <%= s3_upload_form_tag  :key => 'uploads',
                :redirect => image_processing_url,
                :acl => 'public-read',
                :max_filesize => 5.megabytes,
                :submit_button => submit_tag("Upload!") %>

### Configuration

To configure s3_upload_form use s3_upload_form generator...
  ./script/generate s3_upload_form

... and edit the generated initializer file s3_upload_form.rb.

*Jakub Kuźma, 2009*

The gem is based on D2S3 plugin by Matthew Williams.
