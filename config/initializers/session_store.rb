Rails.application.config.session_store :cookie_store, key: "Rails"
Rails.application.config.session_store :cookie_store, secret: "_your_app_session"
Rails.application.config.session_store :cookie_store, expire_after: 1.day
Rails.application.config.session_store :cookie_store, path: "/"
Rails.application.config.session_store :cookie_store, domain: "*"
Rails.application.config.session_store :cookie_store, secure: true
Rails.application.config.session_store :cookie_store, httponly: true
