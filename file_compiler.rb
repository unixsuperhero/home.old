module FileBuilder
  def fb_file_list!
    @fb_file_list = nil
  end

  def fb_files!
    @fb_files = nil
  end

  def fb_file_list
    @fb_file_list ||= []
  end

  def fb_files
    @fb_files ||= {}
  end

  def incl(fname)
    fb_file_list << fname unless fb_file_list.include?(fname)
    fb_files[fname] = IO.read(fname)
    printf "%s loaded...\n", fname
  end

  def bashrc(&compile)
    compile.call
    data = fb_files.flat_map{|fname,fdata|
      [
        format('# File: %s', fname),
        fdata
      ]
    }.join("\n\n")

    print 'Writing compiled.bashrc ... '
    bytes_written = IO.write('compiled.bashrc', data)
    puts 'done'

    printf "Bytes written: %d\n", bytes_written

    fb_files!
    fb_file_list!
  end
end

