class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

# Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
  #   For Rails 3.1+ asset pipeline compatibility:
  #   ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
      [thumb, "default.png"].compact.join('_')
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [150, 150]
  end
  version :thumb_mini do
    process resize_to_fit: [100, 100]
  end
  version :thumb_big do
    process resize_to_fit: [300, 300]
  end
end
