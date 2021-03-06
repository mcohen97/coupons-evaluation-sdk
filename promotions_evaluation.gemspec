lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "promotions_evaluation/version"

Gem::Specification.new do |spec|
  spec.name          = "promotions_evaluation"
  spec.version       = PromotionsEvaluation::VERSION
  spec.authors       = ["="]
  spec.email         = ["diegomarcel27@hotmail.com"]

  spec.summary       = %q{Write a short summary, because RubyGems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "lib/promotions_evaluation"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "faraday_middleware"
end
