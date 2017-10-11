require_relative '../spec_helper'

RSpec.describe SmcUtil::FileReader do
  it 'should load a valid file without raising an error' do
    SmcUtil::FileReader.parse(File.expand_path('../fixtures/flasher_base.smc', __dir__))
  end
end