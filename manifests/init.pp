# A module which sets up google chrome browser, currently only on ubuntu systems
class chrome {

  # Google repository configuration based on
  # http://www.google.com/linuxrepositories/apt.html

  # if($chrome::is_desktop == 'true'){


    # Add Google's apt-key.
    # Assumes definition elsewhere of an Exec["apt-get update"] - or
    # uncomment below.
    $key = 'https://dl-ssl.google.com/linux/linux_signing_key.pub'

    apt::key {'chrome':
      key        => '7FAC5991',
      key_source => $key
    }

    apt::source { 'chrome':
      location    => 'http://dl.google.com/linux/chrome/deb',
      release     => 'stable',
      repos       => 'main',
      include_src => false,
    }

    # Install latest stable; remove beta first, if present:
    package { 'google-chrome-beta':
      ensure => absent,
    }

    package { 'google-chrome-stable':
      ensure  => latest, # to keep current with security updates
      require => [Package['google-chrome-beta']],
    }

  # }
}

