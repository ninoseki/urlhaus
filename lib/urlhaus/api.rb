# frozen_string_literal: true

require "json"
require "net/https"
require "uri"

module URLhaus
  class API
    # The path to the REST API endpoint.
    HOST = "urlhaus-api.abuse.ch"
    VERSION = "v1"
    BASE_URL = "https://#{HOST}/#{VERSION}"

    def url(url)
      post("/url/", url: url)
    end

    def host(host)
      post("/host/", host: host)
    end

    def payload(hash)
      len = hash.length
      case len
      when 32
        params = { md5_hash: hash }
      when 64
        params = { sha256_hash: hash }
      else
        raise ArgumentError("Hash should be MD5 or SHA256")
      end

      post("/payload/", params)
    end

    def tag(tag)
      post("/tag/", tag: tag)
    end

    def signature(signature)
      post("/signature/", signature: signature)
    end

    def download(sha256)
      get("/download/#{sha256}")
    end

    private

    def _host
      self.class::HOST
    end

    def base_url
      self.class::BASE_URL
    end

    def request(req)
      Net::HTTP.start(_host, 443, https_options) do |http|
        response = http.request(req)

        if response.code.to_i != 200
          raise Error, "#{response.code}: #{response.body}"
        end

        JSON.parse response.body
      end
    end

    # Perform a direct GET HTTP request to the REST API.
    def get(path, **params)
      uri = URI("#{base_url}#{path}")
      uri.query = URI.encode_www_form(params) if params
      req = Net::HTTP::Get.new(uri)
      request req
    end

    # Perform a direct POST HTTP request to the REST API.
    def post(path, **params)
      uri = URI("#{base_url}#{path}")
      req = Net::HTTP::Post.new(uri)
      req.set_form_data(params) if params

      request req
    end

    def https_options
      if proxy = ENV["HTTPS_PROXY"] || ENV["https_proxy"]
        uri = URI(proxy)
        {
          proxy_address: uri.hostname,
          proxy_port: uri.port,
          proxy_from_env: false,
          use_ssl: true,
        }
      else
        { use_ssl: true }
      end
    end
  end
end
