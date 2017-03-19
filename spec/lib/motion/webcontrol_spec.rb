require 'spec_helper'
require_relative '../../../lib/motion/webcontrol'

describe 'Motion::Webcontrol url: localhost:9999, thread: 1' do
  subject { Motion::Webcontrol.new(url: 'http://localhost:9999', thread: 1) }

  before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  after do
    WebMock.allow_net_connect!
    WebMock.reset!
  end

  describe '.snapshot' do
    describe 'when webcontrol respond with success' do
      before { stub_request(:any, /localhost:9999/) }
      it { expect(subject.snapshot).to be true }

      it do
        subject.snapshot
        expect(WebMock).to have_requested(:get, 'http://localhost:9999/1/action/snapshot')
      end
    end

    describe 'when webcontrol respond with error' do
      before { stub_request(:any, /localhost:9999/).to_return(status: [500, "Internal Server Error"]) }
      it { expect(subject.snapshot).to be false }
    end
  end
end
