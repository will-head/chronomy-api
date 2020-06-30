require 'faraday'
require 'json'
require 'uri'
require 'net/http'
require 'rest-client'
require 'addressable/uri'

class TiktoksController < ApplicationController
  
  # rubocop:disable Layout/LineLength
  AGENT = "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0) Gecko/20100101 Firefox/78.0"
  # rubocop:enable Layout/LineLength
  
  def self.create(url)
    # url = params['original_url']
    tiktok = Tiktok.create(title: get_title(url), original_url: url, 
      mp4_url: get_mp4_url(url)
      )
    if tiktok.save
      render json: { status: 200, tiktok: tiktok }
    else
      render json: { status: 500 }
    end
  end

  def self.show
    tiktok = Tiktok.find(params[:id])
    if tiktok
      render json: { status: 200, tiktok: tiktok }
    else
      render json: { status: 500 }
    end
  end

  def self.unshorten(url)
    final_url = nil
    RestClient.get(url, :user_agent => AGENT, :cookies => @cookies) { 
      |response, request, &block|
      if [301, 302, 307].include? response.code
        response.follow_redirection(&block)
      else
        final_url = request.url; response.return!(&block)
      end
    }
    strip_params(final_url)
  end

  def self.get_title(url)
    api_url = "https://www.tiktok.com/oembed?url=#{url}"
    response = Faraday.get(api_url) 
    return JSON.parse(response.body)["title"]
  end

  def self.get_mp4_url(url)
    data = {
      :url => url
    }

    api_url = "https://tiktok.fail/api/geturl"

    response = Faraday.post(api_url) do |req|
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = URI.encode_www_form(data)
    end
    puts JSON.parse(response.body)["direct"]
    return JSON.parse(response.body)["direct"]
  end

  def self.strip_params(url)
    uri = Addressable::URI.parse(url)
    uri.query_values = []
    uri.to_s.chomp('?')
  end
end
