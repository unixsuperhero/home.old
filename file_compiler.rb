module FileCompiler
  def included_files
    @included_data ||= []
  end

  def incl(relative_filename)
    rel_file = File.join(Dir.pwd, relative_filename)
    printf 'SKIPPING "%s" ... file not found\n', rel_file
    included_files << IO.read(rel_file)
  end

  def save
    save_as 'compiled.bashrc'
  end

  def save_as(outfile)
    IO.write(outfile, included_files.flatten.join("\n"))
    printf 'Saved "%s", either move it to your home directory and rename', outfile
    printf "it\n\n\t"
    printf "~/.bashrc\n\n"
    printf "or include in your ~/.bashrc file."
  end
end
