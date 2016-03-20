Pod::Spec.new do |s|
  s.name = 'Inu'
  s.version = '0.1.0'
  s.license = 'MIT'
  s.homepage = 'https://github.com/bannzai/'
  s.summary = 'Table view datasource and delegate library in Swift'
  s.authors = { 'yukiasai' => 'kingkong999yhirose@gmail.com' }
  s.source = { :git => 'https://github.com/bannzai/Inu.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  
  s.source_files = 'Classes/*.swift'
end


