class loja_virtual::ci inherits loja_virtual { 
  
<<<<<<< HEAD
  package { ['git', 'maven2', 'openjdk-6-jdk']:
		ensure => "installed",
  }
=======
  
  package { ['git', 'maven2', 'openjdk-6-jdk', 'ruby1.9.3']:
		ensure => "installed",
  }
  
#  package { 'rubygems':
#		ensure => "installed",
#		require    => Package['ruby1.9.3'],
# }

# package { 'ruby1.8':
#		ensure => "purged",
#  }

# package { 'fpm':
#		ensure => "installed",
#		provider   => 'gem',
#		require    => Package['ruby1.9.3'],
# } 
>>>>>>> parent of 73e3f0a... remoção do arquivo ci.pp de qualquer referencia aa instalação do rubygems. Esta vai ser feito de dentro da maquina. Mais no Arquivo README

  class { 'jenkins':
	config_hash => {
		'JAVA_ARGS' => { 'value' => '-Xmx256m' }
  	},
  }
$plugins = [
 'ssh-credentials',
 'credentials',
 'scm-api',
 'git-client',
 'git',
 'maven-plugin',
 'javadoc',
 'mailer',
 'greenballs',
 'ws-cleanup',
 ]

 jenkins::plugin { $plugins: }

 file {'/var/lib/jenkins/hudson.tasks.Maven.xml':
  owner		=> 'jenkins',
  group		=> 'jenkins',
  mode 		=> 0644,
  source 	=> "puppet:///modules/loja_virtual/hudson.tasks.Maven.xml",
  require 	=> Class["jenkins::package"],
  notify 	=> Service["jenkins"],
 }

$job_structure = [
	'/var/lib/jenkins/jobs/',
	'/var/lib/jenkins/jobs/loja-virtual-devops',
]

$git_repository = 'https://github.com/lmbleandro/loja-virtual-devops.git'
$git_poll_interval = '* * * * *'
$maven_goal = 'install'

$archive_artifacts = 'combined/target/*.war'
$repo_dir = '/var/lib/apt/repo'
$repo_name = 'devopspkgs'

file { $job_structure:
  ensure	=> 'directory',
  owner		=> 'jenkins',
  group		=> 'jenkins',
  require 	=> Class['jenkins::package'],
}

file { "${job_structure[1]}/config.xml":
  mode 		=> 0644,
  owner		=> jenkins,
  group		=> jenkins,
  content 	=> template('loja_virtual/config.xml'),
  require 	=> File[$job_structure],
  notify 	=> Service["jenkins"],
 }

<<<<<<< HEAD
  
 class { 'loja_virtual::repo':
=======

# file { "/etc/alternatives/ruby":
#  ensure => '/usr/bin/ruby1.9.3',
#owner		=> root,
#  group		=> root,
#  mode 		=> 777,
#  source 	=> "puppet:///modules/loja_virtual/files/ruby",
#  require 	=> Package["ruby1.9.3"],
# file { '/tmp/link-to-motd':
#    ensure => '/etc/motd',
# } 
#}
  class { 'loja_virtual::repo':
>>>>>>> parent of 73e3f0a... remoção do arquivo ci.pp de qualquer referencia aa instalação do rubygems. Esta vai ser feito de dentro da maquina. Mais no Arquivo README
    basedir => $repo_dir,
    name    => $repo_name,
  }

}



