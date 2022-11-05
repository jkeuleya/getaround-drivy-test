# Please run specs folder by folder
# $ rspec spec/level4

require_relative '../../level4/main'

RSpec.describe 'Main' do
  describe 'run' do
    it 'creates the output file' do
      run

      expect(File).to exist('./level4/data/output.json')
    end

    it 'generates an output identical to the expected one' do
      run

      expected_output = File.read('./level4/data/expected_output.json')
      actual_output = File.read('./level4/data/output.json')

      expect(actual_output).to eq(expected_output)
    end
  end
end
