class TestApiController < ApplicationController
  # rubocop:disable Metrics/MethodLength, Layout/LineLength
  def home
    render json: \
      # { \
      #   "version": "1.0", \
      #   "type": "video", \
      #   "title": "I can’t wit myself💀💀 Instagram;@itsoraida #lmao", \
      #   "author_url": "https://www.tiktok.com/@itsoraida", \
      #   "author_name": "It$oraida", \
      #   "video_url": "https://v.tiktok.fail/b53f119d6bcbad92c55fb1bfa4d5d26d.mp4" \
      # }
    [\
      { \
        "version": "1.0", \
        "type": "video", \
        "title": "Spooky season dance, try it, it’s so fun #fyp #duetthis #dance #halloween #foryou", \
        "author_url": "https://www.tiktok.com/@minecrafter2011", \
        "author_name": "Boomer (2011)", \
        "video_url": "https://v.tiktok.fail/af5bec5b0a331cecc9c49337287bb20c.mp4" \
      }, \
      { \
        "version": "1.0", \
        "type": "video", \
        "title": "#blindinglightschallenge", \
        "author_url": "https://www.tiktok.com/@hannahsimpsonx", \
        "author_name": "Hannah Simpson ", \
        "video_url": "https://v.tiktok.fail/401fa7a6eedaf512427da188e89f37eb.mp4" \
      }, \
      { \
        "version": "1.0", \
        "type": "video", \
        "title": "#fyp", \
        "author_url": "https://www.tiktok.com/@lzz03", \
        "author_name": "lzz", \
        "video_url": "https://v.tiktok.fail/21aa7e634bfdb8bbd41e329d6ea78b78.mp4" \
      }, \
      { \
        "version": "1.0", \
        "type": "video", \
        "title": "❤️❤️#viral #goviral #tiktokindia #trending", \
        "author_url": "https://www.tiktok.com/@bboyrockbittu", \
        "author_name": "bittu soni", \
        "video_url": "https://v.tiktok.fail/c073679a255b9ed5a704fa7c1daa5217.mp4" \
      }, \
      { \
        "version": "1.0", \
        "type": "video", \
        "title": "I can’t wit myself💀💀 Instagram;@itsoraida #lmao", \
        "author_url": "https://www.tiktok.com/@itsoraida", \
        "author_name": "It$oraida", \
        "video_url": "https://v.tiktok.fail/b53f119d6bcbad92c55fb1bfa4d5d26d.mp4" \
      }
    ]
  end
  # rubocop:enable Metrics/MethodLength, Layout/LineLength
end
