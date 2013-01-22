Capistrano::Configuration.instance(:must_exist).load do 

  before "deploy:finalize_update", "varfile:release_config"

  _cset(:varfile_roles) { [:app, :db] }
  _cset(:varfile_shared_path) { File.join(fetch(:shared_path), 'config') }
  _cset(:varfile_filename) { '.env' }
  _cset(:varfile_source_path) { File.join(fetch(:varfile_shared_path), fetch(:varfile_filename)) }
  _cset(:varfile_destination_path) { File.join(fetch(:release_path), fetch(:varfile_filename)) }
  _cset(:varfile_command) { "varfile" }
  _cset(:varfile_options) { "--file=#{fetch(:varfile_source_path)}" }

  namespace :varfile do 
    # This one is supposed to be run during deploy, so I'm using release_path 
    task :release_config, roles: fetch(:varfile_roles) do 
      run "if test -f #{varfile_source_path} ; then cp  #{varfile_source_path} #{release_path} ; fi "
    end

    # The following are supposed to be used on current_path, to set 
    # variables for a live applicaiton or prepare for the next deploy
    desc "copy varfile to current path" 
    task :copy_config_to_current_path, roles: fetch(:varfile_roles) do 
      run "cp -f #{varfile_source_path} #{current_path}"
    end

    desc "list content of config vars in varfile" 
    task :list, roles: fetch(:varfile_roles) do 
      run "cd #{current_path} && #{varfile_command} list #{varfile_options}"
    end

    desc "set value for a key in varfile"
    task :set, roles: fetch(:varfile_roles) do
      key = ENV.fetch('KEY')
      value = ENV.fetch('VALUE')
      run "cd #{current_path} && #{varfile_command} set #{key} #{value} #{varfile_options}"
      copy_config_to_current_path
    end

    desc "remove a key from varfile"
    task :rm, roles: fetch(:varfile_roles) do
      key = ENV.fetch('KEY')

      run "cd #{current_path} && #{varfile_command} rm #{key} #{varfile_options}"
      copy_config_to_current_path
    end
  end

end
