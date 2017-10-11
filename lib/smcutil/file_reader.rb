module SmcUtil
  LINE_COMMAND = /((?<type>[[:upper:]]):(?<offset>([[:xdigit:]]{2})+:)?|(?<continue>\+\s+:))(?<length>\d+):(?<data>([[:xdigit:]]{2})+):(?<check>[[:xdigit:]]{2})/

  class FileReader
    attr_reader :header
    attr_reader :signature
    attr_reader :regions


    def initialize(data)

      # Setup the collected data
      @header = String.new
      @signature = String.new
      @regions = {}

      current_region = nil

      data.each_line.with_index do |line, index|
        # Zero based indexing is not compatible with how people think about lines in a file
        index += 1

        # Prepare to parse the line
        line ||= line.strip!
        puts "INFO: #{line}" && next if line.nil? or line.start_with? '#'
        match = LINE_COMMAND.match(line)
        raise "LINE #{index}: Does not match format" unless match

        # Validate Length
        raise "LINE #{index}: Length mismatch on line; expected #{match[:length]}, got #{match[:data].length / 2}" unless match[:length].to_i == match[:data].length / 2

        # Validate check digit
        data = match[:data].scan(/../).map { |x| x.hex.chr }.join
        check = match[:check].to_i(16)
        sum = data.codepoints.map { |c| c.to_i }.reduce(:+) & 0xFF
        raise "LINE #{index}: Checksum does not match; exptected #{check}, got #{sum}" unless sum == check

        case match[:type]
          when 'H'
            @header += data
          when 'S'
            @signature += data
          when 'D'
            current_region = match[:offset].to_i(16)
            @regions[current_region] = String.new
            @regions[current_region] += data
          else
            raise "LINE #{index}: Command #{match[:type]} not recognised" unless match[:continue]
            raise "LINE #{index}: Continuation row with no data region set" unless current_region

            @regions[current_region] += data
        end
      end
    end

    def self.parse(path)
       FileReader.new(File.open(path))
    end
  end
end