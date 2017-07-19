class bootstrap::profile::cache_gems (
  $cache_dir = '/var/cache/rubygems',
  $file_cache = '/training/file_cache',
) {
  Bootstrap::Gem {
    cache_dir => "${cache_dir}/gems",
  }

  file { $cache_dir :
    ensure => directory,
  }

  #Check for local build file cache from packer or vagrant
  if file_exists ("${file_cache}/gems") == 1 {
    file { "${cache_dir}/gems" :
      ensure => directory,
      recurse => true,
      source => "${file_cache}/gems",
      require => File[$cache_dir],
    }
  }
  else {
    file { "${cache_dir}/gems" :
      ensure => directory,
      require => File[$cache_dir],
    }
  }

  package { 'builder':
    ensure   => present,
    provider => 'puppet_gem',
    require  => Package['rubygems'],
  }

  exec { 'rebuild_gem_cache':
    command     => "gem generate_index -d ${cache_dir}",
    path        => '/opt/puppetlabs/puppet/bin:/usr/local/bin:/usr/bin:/bin',
    refreshonly => true,
    require     => Package['builder'],
  }

  # this is for the vendored gem install.
  file { '/opt/puppetlabs/puppet/etc':
    ensure => directory,
  }

  # Let's just put .gemrc everywhere!
  file { ['/root/.gemrc', '/.gemrc', '/etc/gemrc', '/opt/puppetlabs/puppet/etc/gemrc']:
    ensure => file,
    source => 'puppet:///modules/bootstrap/gemrc',
  }

  # Please keep this list alphabetized and organized. It makes it much easier to update.
  # Puppet Enterprise
  bootstrap::gem { 'hocon':                          version => '1.2.5'  }

  # rspec-puppet and family
  bootstrap::gem { 'diff-lcs':                       version => '1.3'    }
  bootstrap::gem { 'metaclass':                      version => '0.0.4'  }
  bootstrap::gem { 'mocha':                          version => '1.2.1'  }
  bootstrap::gem { 'puppet-lint':                    version => '2.2.1'  }
  bootstrap::gem { 'puppet-syntax':                  version => '2.4.0'  }
  bootstrap::gem { 'puppetlabs_spec_helper':         version => '2.1.2'  }
  bootstrap::gem { 'rspec':                          version => '3.6.0'  }
  bootstrap::gem { 'rspec-core':                     version => '3.6.0'  }
  bootstrap::gem { 'rspec-expectations':             version => '3.6.0'  }
  bootstrap::gem { 'rspec-mocks':                    version => '3.6.0'  }
  bootstrap::gem { 'rspec-puppet':                   version => '2.5.0'  }
  bootstrap::gem { 'rspec-support':                  version => '3.6.0'  }

  # serverspec
  bootstrap::gem { 'multi_json':                     version => '1.12.1' }
  bootstrap::gem { 'net-scp':                        version => '1.2.1'  }
  bootstrap::gem { 'net-ssh':                        version => '4.1.0'  }
  bootstrap::gem { 'net-telnet':                     version => '0.1.1'  }
  bootstrap::gem { 'rspec-its':                      version => '1.2.0'  }
  bootstrap::gem { 'sfl':                            version => '2.3'    }
  bootstrap::gem { 'serverspec':                     version => '2.39.1' }
  bootstrap::gem { 'specinfra':                      version => '2.68.0' }

  # formatr, for perlform mco reports
  bootstrap::gem { 'formatr':                        version => '1.10.1' }

  # hiera-eyaml
  bootstrap::gem { 'hiera-eyaml':                    version => '2.0.6'  }
  bootstrap::gem { 'highline':                       version => '1.6.21' }
  bootstrap::gem { 'trollop':                        version => '2.0'    }

  # Sinatra and Puppetfactory gems
  bootstrap::gem { 'abalone':                        version => '0.4.1'  }
  bootstrap::gem { 'rack':                           version => '1.6.8'  }
  bootstrap::gem { 'rack-protection':                version => '1.5.3'  }
  bootstrap::gem { 'rest-client':                    version => '1.8.0'  }
  bootstrap::gem { 'sinatra':                        version => '1.4.8'  }
  bootstrap::gem { 'tilt':                           version => '2.0.7'  }
  bootstrap::gem { 'puppetclassify':                 version => '0.1.7'  }

  # Showoff dependencies
  bootstrap::gem { 'addressable':                    version => '2.5.1'  }
  bootstrap::gem { 'commonmarker':                   version => '0.14.2' }
  bootstrap::gem { 'daemons':                        version => '1.2.4'  }
  bootstrap::gem { 'em-websocket':                   version => '0.3.8'  }
  bootstrap::gem { 'eventmachine':                   version => '1.2.3' }
  bootstrap::gem { 'fidget':                         version => '0.0.4'  }
  bootstrap::gem { 'git-version-bump':               version => '0.15' }
  bootstrap::gem { 'gli':                            version => '2.16.0' }
  bootstrap::gem { 'htmlentities':                   version => '4.3.4'  }
  bootstrap::gem { 'i18n': }
  bootstrap::gem { 'iso-639': }
  bootstrap::gem { 'mini_portile2':                  version => '2.1.0'  }
  bootstrap::gem { 'nokogiri':                       version => '1.6.8.1' }
  bootstrap::gem { 'parslet':                        version => '1.8.0'  }
  bootstrap::gem { 'pkg-config':                     version => '1.1.7'  }
  bootstrap::gem { 'public_suffix':                  version => '2.0.5'  }
  bootstrap::gem { 'rack-contrib':                   version => '1.4.0'  }
  bootstrap::gem { 'redcarpet':                      version => '3.4.0'  }
  bootstrap::gem { 'ruby-dbus':                      version => '0.13.0' }
  bootstrap::gem { 'showoff':                        version => '0.18.1' }
  bootstrap::gem { 'sinatra-websocket':              version => '0.3.1'  }
  bootstrap::gem { 'thin':                           version => '1.7.0'  }

  # puppetdb-ruby & deps
  bootstrap::gem { 'httparty':                       version => '0.15.5' }
  bootstrap::gem { 'multi_xml':                      version => '0.6.0'  }
  bootstrap::gem { 'puppetdb-ruby':                  version => '0.0.1'  }

  # used to provide color output for various scripts
  bootstrap::gem { 'colorize':                       version => '0.8.1'  }

  # Gems needed to complete Learning VM Quests
  bootstrap::gem { 'cowsay':                         version => '0.3.0'  }
  bootstrap::gem { 'daemons':                        version => '1.0.9' } 
  bootstrap::gem { 'eventmachine':                   version => '1.0.4' }
  bootstrap::gem { 'gli':                            version => '2.13.2' }
  bootstrap::gem { 'mono_logger':                    version => '1.1.0' }
  bootstrap::gem { 'pasture':                        version => '0.2.0' }
  bootstrap::gem { 'pg':                             version => '0.19.0' }
  bootstrap::gem { 'rack':                           version => '1.6.4' }
  bootstrap::gem { 'rack-protection':                version => '1.5.3' }
  bootstrap::gem { 'sequel':                         version => '4.42.1' }
  bootstrap::gem { 'sinatra':                        version => '1.4.7' }
  bootstrap::gem { 'tilt':                           version => '2.0.5' }
  bootstrap::gem { 'thin':                           version => '1.7.0' }
  bootstrap::gem { 'webrick':                        version => '1.3.1' } 

  # Add bundler to make r10k & ruby happy
  bootstrap::gem { 'bundler':                        version => '1.10.6' }

  # Required for the aws module
  bootstrap::gem { 'aws-sdk':                        version => '2.9.25' }
  bootstrap::gem { 'aws-sdk-core':                   version => '2.9.25' }
  bootstrap::gem { 'aws-sdk-resources':              version => '2.9.25' }
  bootstrap::gem { 'aws-sigv4':                      version => '1.0' }
  bootstrap::gem { 'jmespath':                       version => '1.3.1'  }

  # Unidentified dependencies
  bootstrap::gem { 'builder':}
  bootstrap::gem { 'systemu':                        version => '2.5.2'  }
  bootstrap::gem { 'blankslate':                     version => '3.1.3'  }
  bootstrap::gem { 'retries':                        version => '0.0.5'  }

  # Required by metrics scripts
  bootstrap::gem { 'jmx':}
  bootstrap::gem { 'table_print':}

  # used by classroom scripts
  bootstrap::gem { 'puppet':}

  # PDF printing stack
  bootstrap::gem { 'kramdown':                       version => '1.13.2' }
  bootstrap::gem { 'mdl':                            version => '0.4.0'  }
  bootstrap::gem { 'mixlib-cli':                     version => '1.7.0'  }
  bootstrap::gem { 'mixlib-config':                  version => '2.2.4'  }
  bootstrap::gem { 'word_wrap':                      version => '1.0.0'  }
  bootstrap::gem { 'puppet-courseware-manager':      version => '0.6.0'  }

  Bootstrap::Gem <| |> -> File['/root/.gemrc']

}
