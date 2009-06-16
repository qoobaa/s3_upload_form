require "singleton"

module D2S3
  class Configuration
    include Singleton

    ATTRIBUTES = [:access_key_id, :secret_access_key, :bucket]

    attr_accessor *ATTRIBUTES
  end

  def self.configuration
    if block_given?
      yield Configuration.instance
    end
    Configuration.instance
  end
end
