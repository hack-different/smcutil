require_relative '../spec_helper'

RSpec.describe SmcUtil::FileValidator do
  it 'should read `flasher_base` and succeed in validation' do
    SmcUtil::FileReader.parse(File.expand_path('../fixtures/flasher_base.smc', __dir__))
  end

  it 'should read `flasher_base`, fuzz the commands and fail' do
    expect { SmcUtil::FileReader.parse(File.expand_path('../fixtures/flasher_base_unknown_command.smc', __dir__)) }.to raise_error String
  end

  it 'should read `flasher_base`, fuzz the length value and fail' do
    expect { SmcUtil::FileReader.parse(File.expand_path('../fixtures/flasher_base_length.smc', __dir__)) }.to raise_error String
  end

  it 'should read `flasher_base`, fuzz the checksum and fail' do
    expect { SmcUtil::FileReader.parse(File.expand_path('../fixtures/flasher_base_checksum.smc', __dir__)) }.to raise_error String
  end

end