require './lib/motion/webcontrol'
require './lib/motion/files'

class MotionService
  def initialize(options = {})
    @webcontrol = Motion::Webcontrol.new
  end

  def snapshot
    @files1     = Motion::Files.new(target_dir: '/var/lib/motion/1')
    @files2     = Motion::Files.new(target_dir: '/var/lib/motion/2')

    if @webcontrol.snapshot
      sleep(0.5)
      [@files1, @files2].map(&:last_snapshot).compact
    else
      nil
    end
  end

  def last_movie(n)
    @files = Motion::Files.new(target_dir: "/var/lib/motion/#{n}")
    @files.last_movie
  end
end
