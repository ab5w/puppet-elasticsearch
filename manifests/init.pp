#
# This module installs elasticsearch with the elasticsearch-head plugin.
#
# Copyright (C) 2013 Craig Parker <craig@paragon.net.uk>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; If not, see <http://www.gnu.org/licenses/>.
#

class elasticsearch ( 

	$esversion = "0.90.3",
	$installdir = "/opt/elasticsearch",

){
	
	Exec { path => '/usr/bin:/usr/sbin/:/bin:/sbin' }

	package {"java-1.7.0-openjdk":
		ensure => "installed",
	} ->

	file { "$installdir":
    	ensure => "directory",
	} ->

	exec {"elastic-wget":
		cwd => "/usr/src",
		command => "wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$esversion.tar.gz",
		creates => "/usr/src/elasticsearch-$esversion.tar.gz",
	} ->

	exec {"elastic-extract":
		cwd => "/usr/src",
		command => "tar -xf elasticsearch-$esversion.tar.gz",
		creates => "/usr/src/elasticsearch-$esversion/LICENSE.txt",
	} ->

	exec {"elastic-move":
		cwd => "/usr/src",
		command => "mv /usr/src/elasticsearch-$esversion/* $installdir/",
		creates => "$installdir/LICENSE.txt",
	} ->

	exec {"wrapper-wget":
		cwd => "/usr/src",
		command => "wget https://github.com/elasticsearch/elasticsearch-servicewrapper/archive/master.zip",
		creates => "/usr/src/master",
	} ->

	exec {"wrapper-unzip":
		cwd => "/usr/src",
		command => "unzip master",
		creates => "/usr/src/elasticsearch-servicewrapper-master/README.md",
	} ->

	exec {"wrapper-move":
		cwd => "/usr/src",
		command => "mv elasticsearch-servicewrapper-master/service $installdir/bin/",
		creates => "$installdir/bin/service/elasticsearch.conf",
	} ->

	exec {"wrapper-install":
		command => "$installdir/bin/service/elasticsearch install",
		creates => "/etc/init.d/elasticsearch",
	} ->

	exec {"chkconfig-on":
		command => "chkconfig elasticsearch on",
		creates => "/etc/init.d/elasticsearch",
	} ->

	exec {"plugin-head-install":
		command => "$installdir/bin/plugin -install mobz/elasticsearch-head",
		creates => "$installdir/plugins/head/_site/index.html",
	} ->
	
	service {"elasticsearch":
		ensure => "running",
	}

}