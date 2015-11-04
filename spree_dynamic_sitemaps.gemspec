Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_dynamic_sitemaps'
  s.version     = '0.50.1'
  s.summary     = 'Google sitemap for Spree stores'
  #s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 2.0.0'

  s.author            = 'bzt'
  # s.email             = ''
  s.homepage          = 'https://github.com/romul/spree_dynamic_sitemaps'
  # s.rubyforge_project = ''

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

end
