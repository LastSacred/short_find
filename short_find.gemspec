
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "short_find/version"

Gem::Specification.new do |spec|
  spec.name          = "short_find"
  spec.version       = ShortFind::VERSION
  spec.authors       = ["Arthur Torres"]
  spec.email         = ["arthurtorres002@gmail.com"]

  spec.summary       = "Allow a user to find things by typing just enough letters to make it unique."
  spec.description   = "Allow a user to find things by typing just enough letters and/or numbers to make it unique. The user can enter a string of letters. Ignoring case, spaces, and special characters, if there is only one match, short_find will return the item that starts with those characters. If no item is matched, or if more than one item is matched it will give an error and allow the user to try again."
  spec.homepage      = 'http://rubygems.org/gems/short_find'
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
    spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
