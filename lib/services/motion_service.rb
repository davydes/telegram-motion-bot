require './lib/motion/webcontrol'
require './lib/motion/files'

class MotionService
  def initialize
    @webcontrol = Motion::Webcontrol.new
    @files      = Motion::Files.new
  end

  def snapshot
    @webcontrol.snapshot ?
      @files.last_snapshot :
      nil
  end
end
