require 'faraday'
require 'json'

class TiktoksController < ApplicationController
  def create
    url = params['original_url']
    tiktok = Tiktok.create(
      title: get_title(url), 
      original_url: url, 
      mp4_url: get_mp4_url(url)
      )
    if tiktok.save
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
    # fail_url = "https://tiktok.fail/api/geturl"
    # response = Faraday.get(fail_url, "url=#{url}")
    # response[:direct]
    "testest"
  end
end


