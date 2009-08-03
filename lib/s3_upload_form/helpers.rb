module S3UploadForm
  module Helpers
    def s3_bucket_url(protocol = "http")
      bucket = S3UploadForm.configuration.bucket

      raise "Please configure S3UploadForm before use" if bucket.blank?

      "#{protocol}://#{bucket}.s3.amazonaws.com/"
    end

    def s3_signature_tag(options = {})
      bucket            = S3UploadForm.configuration.bucket
      access_key_id     = S3UploadForm.configuration.access_key_id
      secret_access_key = S3UploadForm.configuration.secret_access_key

      raise "Please configure S3UploadForm before use" if bucket.blank? or access_key_id.blank? or secret_access_key.blank?

      key               = options.delete(:key) || ""
      redirect          = options.delete(:redirect) || "/"
      acl               = options.delete(:acl) || "public-read"
      expiration_date   = (options.delete(:expiration_date) || 10.hours).from_now.strftime("%Y-%m-%dT%H:%M:%S.000Z")
      filesize          = options.delete(:filesize) || (1..1.megabyte)
      filesize_range    = filesize.kind_of?(Fixnum) ? 1..filesize : filesize

      policy_document = <<-eos
        {
          "expiration": "#{expiration_date}",
          "conditions":
            [
              {"bucket": "#{bucket}"},
              ["starts-with", "$key", "#{key}"],
              {"acl": "#{acl}"},
              {"success_action_redirect": "#{redirect}"},
              ["content-length-range", #{filesize_range.first}, #{filesize_range.last}]
            ]
        }
      eos

      policy = Base64.encode64(policy_document).gsub("\n","")
      signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new("sha1"), secret_access_key, policy)).gsub("\n","")

      content_tag :div, :style => "margin: 0pt; padding: 0pt; display: inline;" do
        content = ""
        content << hidden_field_tag("key", "#{key}/${filename}")
        content << hidden_field_tag("AWSAccessKeyId", access_key_id)
        content << hidden_field_tag("acl", acl)
        content << hidden_field_tag("success_action_redirect", redirect)
        content << hidden_field_tag("policy", policy)
        content << hidden_field_tag("signature", signature)
      end
    end
  end
end
