Pod::Spec.new do |spec|
  spec.name = 'ExampleProject'
  spec.version = '1.0.0'
  spec.homepage = 'https://www.cocoapods.org'
  spec.source = { :git => "<your repository>", :tag => "{spec.version}" }
  spec.authors = '<Your name>'
  spec.license = ''
  spec.summary = 'An example project'
  spec.static_framework = true
  spec.vendored_frameworks = "ExampleFramework.framework"
  spec.libraries = "c++"
  spec.module_name = "#{spec.name}_umbrella"
  spec.ios.deployment_target = '13.0'
end