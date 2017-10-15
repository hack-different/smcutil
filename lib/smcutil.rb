require "smcutil/version"

module SmcUtil
  DEBUG = true

  autoload :FileReader, 'smcutil/file_reader'
  autoload :FileValidator, 'smcutil/file_validator'
  autoload :FileExtractor, 'smcutil/file_extractor'
  autoload :Region, 'smcutil/region'
end
