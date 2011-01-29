require 'rubygems'

SPEC = Gem::Specification.new do |s|
  s.name = "ai4r"
  s.version = "1.10"
  s.author = "Sergio Fierens"
  s.email = "sergio@jadeferret.com"
  s.homepage = "http://ai4r.rubyforge.org"
  s.rubyforge_project = "ai4r"
  s.platform = Gem::Platform::RUBY
  s.summary = <<-DESC.strip.gsub(/\n\s+/, " ")
    Ruby implementations of algorithms covering several
    Artificial intelligence fields, including Genetic
    algorithms, Neural Networks, machine learning, and clustering.
  DESC
  s.files = Dir.glob("{examples,lib}/**/*")
  s.require_path = "lib"
  s.test_files = Dir.glob("{test}/**/*test.rb")
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc"]
  #s.add_dependency("dependency", ">= 0.x.x")
end
