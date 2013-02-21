require "bundler"
Bundler.setup

gemspec = eval(File.read("rack-in-app-purchase.gemspec"))

task :build => "rack-in-app-purchase.gem"

file "rack-in-app-purchase.gem" => gemspec.files + ["rack-in-app-purchase.gemspec"] do
  system "gem build rack-in-app-purchase.gemspec"
end
