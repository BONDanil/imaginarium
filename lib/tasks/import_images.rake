namespace :images do
  desc "Import PNG files from app/assets/images and attach them to Image records"
  task import: :environment do
    # Define the directory where the PNG files are located
    images_directory = Rails.root.join('app', 'assets', 'images')

    # Ensure the ImagePack exists (you mentioned attaching to ImagePack.first)
    image_pack = ImagePack.first
    if image_pack.nil?
      puts "No ImagePack found. Please create an ImagePack first."
      exit
    end

    # Iterate over each PNG file in the directory
    Dir.glob("#{images_directory}/**/*.png").each do |file_path|
      # Create a new Image record
      image = Image.new(pack: image_pack)

      # Attach the PNG file to the Image record
      image.img.attach(io: File.open(file_path), filename: File.basename(file_path))

      # Save the image record
      if image.save
        puts "Successfully created Image for #{File.basename(file_path)}"
      else
        puts "Failed to create Image for #{File.basename(file_path)}"
        puts image.errors.full_messages
      end
    end

    puts "Image import completed."
  end
end
