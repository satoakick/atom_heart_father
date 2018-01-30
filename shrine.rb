require 'shrine'

if ENV["RACK_ENV"] == "deployment"
  require 'shrine/storage/s3'

  s3_options = {
    access_key_id: Aws.config[:credentials].access_key_id,
    secret_access_key: Aws.config[:credentials].secret_access_key,
    region: Aws.config[:region],
    bucket: Settings.aws.s3.upload.bucket,
  }
  Shrine.storages = {
    store: Shrine::Storage::S3.new(prefix: 'uploads/store', **s3_options),
  }

  # public: true が無いとAws::S3::Object#presigned_urlが呼び出されて,
  # 不要な署名用クエリストリングが付加されてしまう
  default_url_opts = { host: Settings.aws.cloudfront.url, public: true }
  Shrine.plugin :default_url_options, cache: default_url_opts, store: default_url_opts
else
  require 'shrine/storage/file_system'
  Shrine.storages = {
    store: Shrine::Storage::FileSystem.new("#{Settings.application_dir}/public", prefix: "uploads/store"),
  }
end
