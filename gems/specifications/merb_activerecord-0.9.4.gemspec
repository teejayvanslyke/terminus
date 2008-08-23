Gem::Specification.new do |s|
  s.name = %q{merb_activerecord}
  s.version = "0.9.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Duane Johnson"]
  s.date = %q{2008-08-12}
  s.description = %q{Merb plugin that provides ActiveRecord support for Merb}
  s.email = %q{canadaduane@gmail.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/active_record", "lib/active_record/merbtasks.rb", "lib/generators", "lib/generators/migration.rb", "lib/generators/model.rb", "lib/generators/resource_controller.rb", "lib/generators/session_migration.rb", "lib/generators/templates", "lib/generators/templates/migration", "lib/generators/templates/migration/schema", "lib/generators/templates/migration/schema/migrations", "lib/generators/templates/migration/schema/migrations/%file_name%.rb", "lib/generators/templates/model", "lib/generators/templates/model/app", "lib/generators/templates/model/app/models", "lib/generators/templates/model/app/models/%file_name%.rb", "lib/generators/templates/resource_controller", "lib/generators/templates/resource_controller/app", "lib/generators/templates/resource_controller/app/controllers", "lib/generators/templates/resource_controller/app/controllers/%file_name%.rb", "lib/generators/templates/resource_controller/app/views", "lib/generators/templates/resource_controller/app/views/%file_name%", "lib/generators/templates/resource_controller/app/views/%file_name%/edit.html.erb", "lib/generators/templates/resource_controller/app/views/%file_name%/index.html.erb", "lib/generators/templates/resource_controller/app/views/%file_name%/new.html.erb", "lib/generators/templates/resource_controller/app/views/%file_name%/show.html.erb", "lib/generators/templates/session_migration", "lib/generators/templates/session_migration/schema", "lib/generators/templates/session_migration/schema/migrations", "lib/generators/templates/session_migration/schema/migrations/%version%_sessions.rb", "lib/merb", "lib/merb/orms", "lib/merb/orms/active_record", "lib/merb/orms/active_record/connection.rb", "lib/merb/orms/active_record/database.yml.sample", "lib/merb/session", "lib/merb/session/active_record_session.rb", "lib/merb_activerecord.rb", "specs/merb_active_record_spec.rb", "specs/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://merbivore.com}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Merb plugin that provides ActiveRecord support for Merb}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<merb-core>, [">= 0.9.4"])
    else
      s.add_dependency(%q<merb-core>, [">= 0.9.4"])
    end
  else
    s.add_dependency(%q<merb-core>, [">= 0.9.4"])
  end
end
