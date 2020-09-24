require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'sub-task-app-strage' # バケット名
    config.fog_credentials = {
      provider: 'AWS',
      AWS_ACCESS_KEY: ENV['AWS_ACCESS_KEY_ID'],
      AWS_SECRET_KEY: ENV['AWS_SECRET_ACCESS_KEY'],
      AWS_REGION: 'ap-northeast-1',
      path_style: true
    }
end
