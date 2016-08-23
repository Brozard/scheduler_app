Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['OMNI_SCHEDULE_TWITTER_KEY'], ENV['OMNI_SCHEDULE_TWITTER_SECRET']
end