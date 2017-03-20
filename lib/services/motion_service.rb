require './lib/motion/webcontrol'
require './lib/motion/files'

class MotionService
  def initialize
    @webcontrol = Motion::Webcontrol.new
    @files1     = Motion::Files.new(target_dir: '/var/lib/motion/1')
    @files2     = Motion::Files.new(target_dir: '/var/lib/motion/2')
  end

  def snapshot
    if @webcontrol.snapshot
      sleep(0.5)
      [@files1, @files2].map(&:last_snapshot).compact
    else
      nil
    end
  end
end
