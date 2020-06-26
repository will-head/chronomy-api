class PlaceholderPlaylistsController < ApplicationController
  # rubocop:disable Metrics/MethodLength
  def home
    render json: \
    [\
      { \
        "id": "1", \
        "title": "playlist1", \
        "uuid": "40c5b468-13af-483d-8728-eb4f85a9f765" \
      }, \
      { \
        "id": "2", \
        "title": "playlist2", \
        "uuid": "ddfd3bcc-bc63-4d78-88e6-8bcc17c0bd41" \
      }, \
      { \
        "id": "3", \
        "title": "playlist3", \
        "uuid": "0ccba4e9-1a7f-43f0-8672-ce8c7eaa7361" \
      } \
    ]
  end
  # rubocop:enable Metrics/MethodLength
end
