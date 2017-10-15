module SmcUtil
  class Region
    attr_accessor :offset, :data

    def initialize(offset, data)
      @offset = offset
      @data = data
    end

    def to_s
      "#{self.offset.to_s(16).upcase} (length #{data.length})"
    end
  end
end