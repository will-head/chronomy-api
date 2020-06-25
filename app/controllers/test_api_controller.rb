class TestApiController < ApplicationController
  def home
    render json: { \
      version: "1.0", \
      type: "video", \
      title: "Spooky season dance, try it, it’s so fun #fyp #duetthis #dance #halloween #foryou", \
      author_url: "https://www.tiktok.com/@minecrafter2011", \
      author_name: "Boomer (2011)", \
      video_url: "https://v.tiktok.fail/af5bec5b0a331cecc9c49337287bb20c.mp4" \
    }
  end
end
