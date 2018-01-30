require "aws-sdk-s3"
require "hashie"

path = "config/secrets.yml"
secrets = Hashie::Mash.load(path) if File.exist?(path)

if secrets && ENV["RACK_ENV"] == "deployment"
  settings = secrets.production
  Aws.config.update(
    region: settings.aws.region,
    credentials: Aws::Credentials.new(settings.aws.access_key_id, settings.aws.secret_access_key)
  )
end
