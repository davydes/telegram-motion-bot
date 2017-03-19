require './lib/motion/webcontrol'

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
