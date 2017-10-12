class SmcUtil::FileExtractor
  OUTPUT_FILE_FLAGS = File::CREAT | File::TRUNC | File::WRONLY

  def initialize(file_reader)
    @file_reader = file_reader
  end


  def extract_to(path)
    File.open(File.join(path, 'header.bin'), OUTPUT_FILE_FLAGS) do |file|
      file.write @file_reader.header
    end

    File.open(File.join(path, 'signature.bin'), OUTPUT_FILE_FLAGS) do |file|
      file.write @file_reader.signature
    end

    File.open(File.join(path, 'binary.bin'), OUTPUT_FILE_FLAGS) do |file|
      @file_reader.regions.each do |offset, content|
        range_bytes = offset - file.pos
        file.write "\0" * range_bytes if range_bytes > 0
        file.write content
      end
    end
  end
end