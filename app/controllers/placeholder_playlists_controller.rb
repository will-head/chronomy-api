class PlaceholderPlaylistsController < ApplicationController

  def home
    render json: \
    [\
      { \
        "id": "1", \
        "title": "playlist1", \
        "uuid": "40c5b468-13af-483d-8728-eb4f85a9f765" \
      } \
    ]
  end

end
