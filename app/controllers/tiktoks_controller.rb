require 'faraday'
require 'json'
require 'uri'
require 'net/http'
require 'rest-client'

class TiktoksController < ApplicationController
  AGENT = "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0) Gecko/20100101 Firefox/78.0"

  def create
    url = params['original_url']
    tiktok = Tiktok.create(title: get_title(url), original_url: url, 
      mp4_url: get_mp4_url(url)
      )
    if tiktok.save
      render json: { status: 200, tiktok: tiktok }
    else
      render json: { status: 500 }
    end
  end

  def show
    tiktok = Tiktok.find(params[:id])
    if tiktok
      render json: { status: 200, tiktok: tiktok }
    else
      render json: { status: 500 }
    end
  end

  def unshorten(url, redirects = 10)
    final_url = nil

    result = RestClient.get(url, :user_agent => AGENT, :cookies => @cookies){ |response, request, result, &block|
      if [301, 302, 307].include? response.code
        response.follow_redirection(&block)
      else
        final_url = request.url
        response.return!(&block)
      end
    }
    strip_params(final_url)
    # return url if redirects <= 0

    # new_url = get_long_url(url)
    # if new_url != url
    #   new_url = unshorten(new_url, redirects - 1)
    # end
    # new_url
  end

  private

  def get_title(url)
    api_url = "https://www.tiktok.com/oembed?url=#{url}"
    response = Faraday.get(api_url) 
    return JSON.parse(response.body)["title"]
  end

  def get_mp4_url(url)
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

#   def get_long_url(short_url)
#     uri = URI.parse(short_url)
#     http = Net::HTTP.new(uri.host)
#     request = Net::HTTP::Get.new(uri.path)
#     request["User-Agent"] = "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0) Gecko/20100101 Firefox/78.0"
#     # request["Accept"] = "*/*"
#     # response = http.request(request)
#     response = Net::HTTP.start(uri.hostname, uri.port) {|http|
#   http.request(req)
# }
#     response.each_header do |key, value|
#       p "#{key} => #{value}"
#     end
#     response.fetch('location')
#   end

  def strip_params(url)
    uri = Addressable::URI.parse(url)
    uri.query_values = []
    uri.to_s.chomp('?')
  end

end
