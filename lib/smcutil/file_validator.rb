require 'openssl'

module SmcUtil
  class FileValidator
    attr_reader :file, :errors

    def initialize(file)
      @file = file
    end

    def validate!
      @errors = []

      validate_regions!
      validate_headers!
      validate_signature!
    end

    def valid?
      validate!

      !@errors.any?
    end

    def validate_regions!
      @file.regions.any?
    end

    def validate_headers!
      return false unless @file.headers.any? || (@file.headers.count != @file.regions.count)

      hash_algorithm = nil

      case @file.headers[0].length
      when 20
        hash_algorithm = OpenSSL::Digest::SHA1
      when 32
        hash_algorithm = OpenSSL::Digest::SHA256
      when 64
        hash_algorithm = OpenSSL::Digest::SHA512
      else
        @errors << "ERROR: Digest of header row with length #{@file.headers[0].count} bytes is unsupported.  (But pull requests are accepted)" and return
      end

      zipped_regions = @file.regions.zip(@file.headers)
      zipped_regions.each do |region, header|
        begin
          hash = hash_algorithm.new

          hash << region.data

          if hash.digest == header
            puts "DEBUG: Validated hash for region #{region}" if SmcUtil::DEBUG
          else
            @errors << "Header hash for region #{region} does not match expected"
          end
        rescue => ex
          puts "ERROR: #{ex}"
          puts ex.backtrace
        end
      end
    end

    def validate_signature!
      # TODO: Find the RSA 2048 bit key that signs this
    end
  end
end
