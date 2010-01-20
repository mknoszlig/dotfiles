namespace :install do
  desc "install vcprompt from github"
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
end
