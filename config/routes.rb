Rails.application.routes.draw do
  root to: "static#home"

  get "/test_api/" => "test_api#home"
end
