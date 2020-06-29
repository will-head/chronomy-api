if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_chronomy", domain: "chronomy.herokuapp.com"
else
  Rails.application.config.session_store :cookie_store, key: "_chronomy"
end
