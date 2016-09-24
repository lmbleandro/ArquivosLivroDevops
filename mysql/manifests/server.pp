class mysql::server {

	package { "vim":
	  ensure => installed,
	}
	
	package { "mysql-server":
	  ensure => installed,
	}

	service {"mysql":
	 ensure => running,
	 enable => true,
	 hasstatus => true,
	 hasrestart => true,
	 require => Package["mysql-server"],

	}

	file {"/etc/mysql/conf.d/allow_external.cnf":
	 owner => mysql,
	 group => mysql,
	 mode => 0644,
	 content => template("mysql/allow_ext.cnf"),
	 require => Package["mysql-server"],
	 notify => Service["mysql"],

	}

#	exec { "set-mysql-password":
#	     path => '/usr/bin',
#	     command => "mysqladmin -uroot password secret",
#	     require => Service['mysql'],
#	 }

	exec { "remove-anonymous-user":
	     command => "mysql -uroot -e \"DELETE FROM mysql.user WHERE user=''; flush privileges\"",
	     onlyif => "mysql -u ' '",
	     path => "/usr/bin",
	     require => Service["mysql"],
	}


}

