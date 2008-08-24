set :application, "t.ermin.us"
set :repository,  "git://github.com/teejayvanslyke/webterm.git"
set :domain,      "t.ermin.us"
set :user,        'deploy'

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, domain
role :web, domain
role :db,  domain, :primary => true

desc "Link in the production extras" 
task :after_symlink do
  # symlink log path
  run "ln -nfs #{shared_path}/log #{release_path}/log" 
end

namespace :deploy do
  desc "Merb it up" 
  task :restart do
    run "cd #{current_path}; merb -k 4000"
    run "cd #{current_path}; merb -e production -c 1" # plain old mongrel
  end
end
