if Rails.env.development?
  $redis = Redis.new(host: 'localhost', port: 6379, db: 2)
elsif Rails.env.test?
  $redis = Redis.new(host: 'localhost', port: 6379, db: 3)
elsif Rails.env.staging?
  $redis = Redis.new(host: ENV['REDIS_HOST'], port: 6379, db: 2)
elsif Rails.env.production?
  $redis = Redis.new(host: ENV['REDIS_HOST'], port: 6379, db: ENV['REDIS_DB'])
end