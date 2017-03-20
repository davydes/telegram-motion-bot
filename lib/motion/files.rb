module Motion
  class Files
    def initialize(options = {})
      @path = options[:target_dir] || '/var/lib/motion'
      @snapshot_files = options[:snapshot_filename_mask] || '*-snapshot.jpg'
      @movie_files = options[:movie_filename_mask] || '*.avi'
    end


    def last_snapshot
      last_file(@snapshot_files)
    end

    def last_movie
      last_file(@movie_files)
    end

    private

    def last_file(mask)
      Dir.glob("#{@path}/**/#{mask}").max_by { |i| File.mtime(i) }
    end
  end
end
