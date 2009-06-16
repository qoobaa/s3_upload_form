# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{s3_upload_form}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jakub Kuźma"]
  s.date = %q{2009-06-16}
  s.email = %q{qoobaa@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "generators/s3_upload_form/s3_upload_form_generator.rb",
     "generators/s3_upload_form/templates/initializers/s3_upload_form.rb",
     "lib/s3_upload_form.rb",
     "lib/s3_upload_form/configuration.rb",
     "lib/s3_upload_form/helpers.rb",
     "s3_upload_form.gemspec",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/qoobaa/s3_upload_form}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{S3 file upload form}
  s.test_files = [
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
