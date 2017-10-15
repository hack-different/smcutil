module SmcUtil
  class Region
    attr_accessor :offset, :data

    def initialize(offset, data)
      @offset = offset
      @data = data
    end

    def to_s
      "#{self.offset} (length #{data.length})"
    end
  end
end