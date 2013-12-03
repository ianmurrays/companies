class PassportUploader < CarrierWave::Uploader::Base
  storage :file

  def extension_white_list
    %w(pdf)
  end
end