require 'base64'

module D2S3
  module ViewHelpers
    include D2S3::Signature

    def s3_upload_form_tag(options = {})
      bucket          = D2S3.configuration.bucket
      access_key_id   = D2S3.configuration.access_key_id
      protocol        = options[:protocol] || "http"
      key             = options[:key] || ''
      redirect        = options[:redirect] || '/'
      acl             = options[:acl] || 'public-read'
      expiration_date = (options[:expiration_date] || 10.hours).from_now.strftime('%Y-%m-%dT%H:%M:%S.000Z')
      max_filesize    = options[:max_filesize] || 1.megabyte
      submit_button   = options[:submit_button] || %(<input type="submit" value="#{I18n.t("button.upload")}">)

      options[:form] ||= {}
      options[:form][:id] ||= 'upload-form'
      options[:form][:class] ||= 'upload-form'

      policy = Base64.encode64(
                               %({"expiration": "#{expiration_date}",
          "conditions": [
            {"bucket": "#{bucket}"},
            ["starts-with", "$key", "#{key}"],
            {"acl": "#{acl}"},
            {"success_action_redirect": "#{redirect}"},
            ["content-length-range", 0, #{max_filesize}]
          ]
        })).gsub(/\n|\r/, '')

      signature = b64_hmac_sha1(D2S3.configuration.secret_access_key, policy)
      out = ""
      out << %(
          <form action="#{protocol}://#{bucket}.s3.amazonaws.com/" method="post" enctype="multipart/form-data" id="#{options[:form][:id]}" class="#{options[:form][:class]}" style="#{options[:form][:style]}">
          <input type="hidden" name="key" value="#{key}/${filename}">
          <input type="hidden" name="AWSAccessKeyId" value="#{access_key_id}">
          <input type="hidden" name="acl" value="#{acl}">
          <input type="hidden" name="success_action_redirect" value="#{redirect}">
          <input type="hidden" name="policy" value="#{policy}">
          <input type="hidden" name="signature" value="#{signature}">
          <input name="file" type="file">#{submit_button}
          </form>
        )
    end
  end
end

ActionView::Base.send(:include, D2S3::ViewHelpers) if defined?(ActionView::Base)
