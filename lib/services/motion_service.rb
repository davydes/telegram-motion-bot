require './lib/motion/webcontrol'
require './lib/motion/files'

class MotionService
  def initialize
    @webcontrol = Motion::Webcontrol.new
    @files      = Motion::Files.new
  end

  def snapshot
    if @webcontrol.snapshot
      sleep(0.5)
      @files.last_snapshot
    else
      nil
    end
  end
end
