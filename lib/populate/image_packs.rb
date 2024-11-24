module Populate
  module ImagePacks
    BUCKET_NAME = "imaginarium-image-packs".freeze

    def s3_client
      @s3_client ||= Aws::S3::Client.new(
        access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
        secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
        region: Rails.application.credentials.dig(:aws, :region)
      )
    end

    def image_present?(pack_id, filename)
      Image.joins(file_attachment: :blob)
           .where(
             active_storage_blobs: { filename: },
             pack_id:
           ).exists?
    end
  end
end
