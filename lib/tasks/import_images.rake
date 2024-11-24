require "populate/image_packs"

namespace :images do
  desc "Import image packs from S3 and create ImagePack and Image records"
  task import: :environment do
    include Populate::ImagePacks

    s3_client.list_objects_v2(bucket: BUCKET_NAME, delimiter: '/').common_prefixes.each do |prefix|
      pack_name = prefix[:prefix].chomp('/')
      image_pack = ImagePack.find_or_create_by!(name: pack_name)

      s3_client.list_objects_v2(bucket: BUCKET_NAME, prefix: prefix[:prefix]).contents.each do |file|
        next if file.key.end_with?('/')

        filename = File.basename(file.key)
        next if image_present?(image_pack.id, filename)

        image = Image.new(pack: image_pack)
        s3_file = s3_client.get_object(bucket: BUCKET_NAME, key: file.key)
        image.file.attach(io: StringIO.new(s3_file.body.read), filename:)

        if image.save
          puts "."
        else
          puts "Failed to create Image for #{file.key}: #{image.errors.full_messages}"
        end
      end
    end

    puts "Image import completed."
  end
end
