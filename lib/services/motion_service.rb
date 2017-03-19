require './lib/motion/webcontrol'

class MotionService
  def initialize
    @webcontrol = Motion::Webcontrol.new
  end

  def snapshot
    @webcontrol.snapshot
  end
end
