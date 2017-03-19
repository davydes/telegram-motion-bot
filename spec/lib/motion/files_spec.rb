require 'spec_helper'
require_relative '../../../lib/motion/files'

describe Motion::Files do
  describe '.last_snapshot' do
    before do
      files = {
        'snapshot1.jpg' => Time.new(2017, 01, 01, 11, 00),
        'snapshot2.jpg' => Time.new(2017, 01, 01, 19, 00),
        'snapshot3.jpg' => Time.new(2017, 01, 01, 12, 00)
      }
      allow(Dir).to receive(:glob).and_return(files.keys)
      allow(File).to receive(:mtime) { |filename| files[filename] }
    end

    it { expect(subject.last_snapshot).to eq 'snapshot2.jpg' }
  end
end
