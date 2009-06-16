# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{d2s3}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Williams", "Jakub Kuźma"]
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
     "d2s3.gemspec",
     "generators/d2s3/d2s3.rb",
     "generators/d2s3/templates/initializers/d2s3.rb",
     "lib/d2s3.rb",
     "lib/d2s3/configuration.rb",
     "lib/d2s3/signature.rb",
     "lib/d2s3/view_helpers.rb",
     "test/signature_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/qoobaa/d2s3}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{direct to s3}
  s.test_files = [
    "test/signature_test.rb",
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
