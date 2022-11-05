# Please run specs folder by folder
# $ rspec spec/level2

require_relative '../../level2/main'

RSpec.describe 'Main' do
  describe 'run' do
    it 'creates the output file' do
      run

      expect(File).to exist('./level2/data/output.json')
    end

    it 'generates an output identical to the expected one' do
      run

      expected_output = File.read('./level2/data/expected_output.json')
      actual_output = File.read('./level2/data/output.json')

      expect(actual_output).to eq(expected_output)
    end
  end
end
