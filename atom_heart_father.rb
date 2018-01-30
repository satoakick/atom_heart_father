class AtomHeartFather
  require "image_processing/mini_magick"
  include ImageProcessing::MiniMagick

  def call(env)
    request = Rack::Request.new(env)
    original = download(Shrine.storages[:store], request.path_info)
    resized = resize(original, weight: request.params["w"], height: request.params["h"])

    [ 200, { "Content-Type" => "image/jpg" }, [resized.read] ] if request.get?
  ensure
    original.close! if original
    resized.close! if resized
  end

  def download(storage, key)
    key = key[1..-1] # Note that the first slash of key will be removed.
    if ENV["RACK_ENV"] == "deployment"
      storage.download(key)
    else
      tempfile = Tempfile.new(["shrine-filesystem", File.extname(key)], binmode: true)
      storage.open(key) { |file| IO.copy_stream(file, tempfile) }
      tempfile.tap(&:open)
    end
  end

  def resize(file, weight:, height:)
    resize_to_fit(file, weight, height) do |cmd|
      cmd.quality(92) # see https://www.imagemagick.org/script/command-line-options.php#quality
      cmd.alpha("remove")
    end
  end
end
