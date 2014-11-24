# -------
# Fetch PE and unzip full installer
# Stage agent installer.
# -------

class bootstrap::get_pe(
  $version   = 'latest'
) {
  $pe_destination = "/root/"
  $architecture   = 'i386'
  $pe_dir        = "puppet-enterprise-${version}-el-6-${architecture}"
  $pe_file        = "${pe_dir}.tar.gz"
  $agent_file     = "puppet-enterprise-${version}-el-6-${architecture}-agent.tar.gz"
  $url            = "https://s3.amazonaws.com/pe-builds/released/${version}"

  if file_exists ("/tmp/installers/") == 1 {
    staging::file{ $agent_file:
      source => "/tmp/installers/${agent_file}",
    }

    staging::file{ $pe_file:
      source => "/tmp/installers/${pe_file}",
    }
  }
  else {
    staging::file{ $agent_file:
      source => "${url}/${agent_file}",
    }

    staging::file{ $pe_file:
      source => "${url}/${pe_file}",
    }
  }
  staging::extract{ $pe_file:
    target => "${pe_destination}",
    require => Staging::File[ $pe_file ],
  }

  file { "${pe_destination}/puppet-enterprise":
    ensure => link,
    target => "${pe_destination}/${pe_dir}",
    require => Staging::Deploy[ $pe_file ],
  }
}
