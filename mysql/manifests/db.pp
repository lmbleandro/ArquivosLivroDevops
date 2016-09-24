define mysql::db($schema, $user = $title, $password) {
	Class['mysql::server'] -> Mysql::Db[$title]

	exec { "$title-schema":
	 unless => "mysql -uroot $schema",
	 command => "mysqladmin -uroot create $schema",
	 path => "/usr/bin",

	}

	exec { "$title-$user":
	 unless => "mysql -u$user -p$password $schema",
	 command => "mysql -uroot -e \"grant all privileges on $schema.* to '$user'@'%' identified by '$password';\"",
	 path => "/usr/bin",
	 require => Exec["$title-schema"],

	}

}

