require 'faraday'
require 'json'
require 'uri'
require 'net/http'

class TiktoksController < ApplicationController
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
end
