#!/usr/bin/env ruby

require 'xcodeproj'

project_path = 'Pods/Pods.xcodeproj'
project = Xcodeproj::Project.open(project_path)

def remove_g_flag(config)
  if config.build_settings['OTHER_CFLAGS']
    config.build_settings['OTHER_CFLAGS'] = config.build_settings['OTHER_CFLAGS'].gsub(/-G\s*/, '')
  end
  if config.build_settings['OTHER_LDFLAGS']
    config.build_settings['OTHER_LDFLAGS'] = config.build_settings['OTHER_LDFLAGS'].gsub(/-G\s*/, '')
  end
  if config.build_settings['OTHER_CPLUSPLUSFLAGS']
    config.build_settings['OTHER_CPLUSPLUSFLAGS'] = config.build_settings['OTHER_CPLUSPLUSFLAGS'].gsub(/-G\s*/, '')
  end
end

project.targets.each do |target|
  if target.name.include?('gRPC') || target.name.include?('BoringSSL') || target.name.include?('abseil')
    target.build_configurations.each do |config|
      remove_g_flag(config)
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'GRPC_CFSTREAM=1'
      config.build_settings['CLANG_CXX_LANGUAGE_STANDARD'] = 'c++14'
      config.build_settings['CLANG_CXX_LIBRARY'] = 'libc++'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
      
      if config.build_settings['SDKROOT'] == 'iphonesimulator'
        config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'i386'
      end
    end
  end
end

project.save 