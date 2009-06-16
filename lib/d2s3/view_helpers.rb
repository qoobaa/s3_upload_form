module D2s3
  module ViewHelpers
    def s3_upload_form_tag(options = {})
      bucket            = D2s3.configuration.bucket
      access_key_id     = D2s3.configuration.access_key_id
      secret_access_key = D2s3.configuration.secret_access_key

      raise "Please configure D2s3 before use" unless bucket and access_key_id and secret_access_key

      protocol          = options.delete(:protocol) || "http"
      key               = options.delete(:key) || ""
      redirect          = options.delete(:redirect) || "/"
      acl               = options.delete(:acl) || "public-read"
      expiration_date   = (options.delete(:expiration_date) || 10.hours).from_now.strftime("%Y-%m-%dT%H:%M:%S.000Z")
      max_filesize      = options.delete(:max_filesize) || 1.megabyte
      submit            = options.delete(:submit_button) || submit_tag(I18n.t("button.upload", :default => "Upload"))

      policy_document = <<-eos
        {
          "expiration": "#{expiration_date}",
          "conditions":
            [
              {"bucket": "#{bucket}"},
              ["starts-with", "$key", "#{key}"],
              {"acl": "#{acl}"},
              {"success_action_redirect": "#{redirect}"},
              ["content-length-range", 0, #{max_filesize}]
            ]
        }
      eos

      policy = Base64.encode64(policy_document).gsub("\n","")
      signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new("sha1"), secret_access_key, policy)).gsub("\n","")

      options[:action] ||= "#{protocol}://#{bucket}.s3.amazonaws.com/"
      options[:method] ||= "post"
      options[:enctype] ||= "multipart/form-data"

      content_tag :form, options do
        content = ""
        content << hidden_field_tag("key", "#{key}/${filename}")
        content << hidden_field_tag("AWSAccessKeyId", access_key_id)
        content << hidden_field_tag("acl", acl)
        content << hidden_field_tag("success_action_redirect", redirect)
        content << hidden_field_tag("policy", policy)
        content << hidden_field_tag("signature", signature)
        content << file_field_tag("file")
        content << submit
      end
    end
  end
end
