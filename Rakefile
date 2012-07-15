namespace :install do
  desc "install vcprompt from github - needs dotfiles"
  task :vcprompt do
    src_loc = ENV['REPO_DIR']
    destination = "#{ENV['HOME']}/bin"
    repository = "git://github.com/simple/vcprompt.git"
    local_name = 'vcprompt'
    executable_name = 'vcprompt'
    executable_path = File.join(src_loc, local_name, executable_name)

    update_or_create_git_repo(ENV['REPO_DIR'], repository, local_name)

    sh "make"
    unless(File.exists?(executable_path))
      raise "executable not found at '#{executable_path}'"
    end
    cp executable_path, destination
  end

  def update_or_create_git_repo(src_loc, repo_uri, local_name)
    repo_path = File.join(src_loc, local_name)
    unless File.exists?(repo_path)
      cd src_loc
      sh "git clone #{repo_uri} #{local_name}"
      cd local_name
    else
      cd repo_path
      sh "git pull"
    end
  end
  
  desc "install magit-blame from github - requires dotfiles, sudo"
  task :magit do
    repository = "git://github.com/mknoszlig/magit.git"
    local_name = "magit"

    update_or_create_git_repo(ENV['REPO_DIR'], repository, local_name)

    sh "sudo make install"
    
  end
  
  desc "install the dot files into user's home directory"
  task :dotfiles do
    globs = [['*', %w[Rakefile README.rdoc LICENSE bin patches]],
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

  desc "install nailgun server/client for use with vimclojure"
  task :nailgun do
  	repo_dir = File.join(ENV['REPO_DIR'], 'vimclojure')
	FileUtils::rm_rf(repo_dir) if File::exists?(repo_dir)
	mkdir repo_dir
	url = "http://www.vim.org/scripts/download_script.php?src_id=11066"
	file = "vimclojure-2.1.2.zip"
	local_path = File.join(repo_dir, file)
	sh "wget #{url} -O #{local_path}"
	sh "cd #{repo_dir} && unzip #{local_path}"
	prop_file = File.join(repo_dir, file.gsub(/.zip$/, ''), 'local.properties')
	File.open(prop_file, 'w') do |f|
		f.puts "clojure.jar = #{}"
		f.puts "clojure-contrib.jar = #{}"
		f.puts "nailgun-client = ng"
		f.puts "vimdir = #{File.join(ENV['HOME'], '.vim')}"
	end

	mkdir ENV['CLOJURE_EXT'] unless File::exists?(ENV['CLOJURE_EXT'])
  end

  def replace_file(file, prefix)
    system %Q{rm -rf "$HOME/#{prefix}#{file.sub('.erb', '')}"}
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
      system %Q{ln -fs "$PWD/#{prefix.sub('.', '')}#{file}" "$HOME/#{prefix}#{file}"}
    end
  end

end
