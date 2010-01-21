namespace :install do
  desc "install vcprompt from github - needs dotfiles"
  task :vcprompt do
    src_loc = ENV['REPO_DIR']
    destination = "#{ENV['HOME']}/bin"
    repository = "git://github.com/simple/vcprompt.git"
    local_name = 'vcprompt'
    repo_path = File.join(src_loc, local_name)
    executable_name = 'vcprompt'
    executable_path = File.join(src_loc, local_name, executable_name)

    unless(File.exists?(repo_path))
      cd src_loc
      sh "git clone #{repository} #{local_name}"
      cd local_name
    else
      cd repo_path
      sh "git pull"
    end
    sh "make"
    unless(File.exists?(executable_path))
      raise "executable not found at '#{executable_path}'"
    end
    cp executable_path, destination
  end

  desc "install the dot files into user's home directory"
  task :dotfiles do
    globs = [['*', %w[Rakefile README.rdoc LICENSE bin]],
     	     ['bin/*', []]]

    globs.each do |glob, ignore|
      replace_all = false
      prefix = glob.gsub(/\*/, '')
      prefix = '.' if prefix.empty?

      Dir[glob].each do |file|
	file = File.basename(file)
        next if ignore.include? file
        if File.exist?(File.join(ENV['HOME'], "#{prefix}#{file.sub('.erb', '')}"))
          if replace_all
            replace_file(file, prefix)
          else
            print "overwrite ~/#{prefix}#{file.sub('.erb', '')}? [ynaq] "
            case $stdin.gets.chomp
            when 'a'
              replace_all = true
              replace_file(file, prefix)
            when 'y'
              replace_file(file, prefix)
            when 'q'
              exit
            else
              puts "skipping ~/#{prefix}#{file.sub('.erb', '')}"
            end
          end
        else
          link_file(file, prefix)
        end
      end
    end
  end

  def replace_file(file, prefix)
    system %Q{rm "$HOME/#{prefix}#{file.sub('.erb', '')}"}
    link_file(file, prefix)
  end

  def link_file(file, prefix)
    if file =~ /.erb$/
      puts "generating #{file.sub('.erb', '')}"
      File.open(File.join(ENV['HOME'], "#{prefix}#{file.sub('.erb', '')}"), 'w') do |new_file|
        new_file.write ERB.new(File.read(file)).result(binding)
      end
    else
      puts "linking ~/#{prefix}#{file}"
      system %Q{ln -fs "$PWD/#{prefix}#{file}" "$HOME/#{prefix}#{file}"}
    end
  end

end
