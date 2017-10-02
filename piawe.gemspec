# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "piawe"
  spec.version       = 1.0
  spec.authors       = ["Juan Lu"]
  spec.email         = ["juanlujoanne@gmail.com"]

  spec.summary       = %q{PIAWE}
  spec.description   = %q{PIAWE is the way we work out how much someone who is unable to work gets paid.
                          In this case we have four people (found in people.json) who need payments.
                          PIAWE is a confusing and difficult thing for both employees and employers
                          but for the purposes of this code test you'll be pleased to know we're going
                          to simplify things a bit.There's a sliding scale of payments based on how long
                          you've been injured, and how you get paid (this can be found in rules.json).}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "require_all"
  spec.add_development_dependency "simplecov"
end
