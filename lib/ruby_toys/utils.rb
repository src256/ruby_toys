module RubyToys
  class Utils
    # コマンドのパスを返す
    def self.which(cmd)
      exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
      ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each do |ext|
          exe = File.join(path, "#{cmd}#{ext}")
          return exe if File.executable?(exe) && !File.directory?(exe)
        end
      end
      return nil
    end

    def self.handle_error(e)
      if e.message =~ /Incorrect string value:/
        # utf8mb4にすればいいのだ…。とりあえずそのばしのぎ。
        puts e.message[0, 100]
      else
        puts e.message
        puts e.backtrace
      end
    end
  end
end