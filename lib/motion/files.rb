module Motion
  class Files
    def initialize(options = {})
      @path = options[:target_dir] || '/var/lib/motion'
      @snapshot_files = options[:snapshot_filename_mask] || '*-snapshot.jpg'
    end

    def last_snapshot
      Dir.glob("#{@path}/**/#{@snapshot_files}").max_by { |i| File.mtime(i) }
    end
  end
end
