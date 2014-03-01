puppet-elasticsearch
====================

Installs elasticsearch with the elasticsearch-head plugin.

http://mobz.github.io/elasticsearch-head/

To install add the following to your nodes manifest;

    class {'elasticsearch':}

It will default to version 1.0.1 and an install path of /opt/elasticsearch

You can also specify the version and the install path like so

    class {'elasticsearch':
        esversion => "0.90.2",
        installdir => "/srv/elasticsearch",
    }

For a clustered setup add the following to each nodes manifest as well as the main class, the clustername needs to be the same on all nodes.

    class { 'elasticsearch::cluster':
        nodename => "example-001",
        clustername => "example-elasticsearch",
    }

If you set a non default install path you will need to specify this

    class { 'elasticsearch::cluster':
        nodename => "example-001",
        clustername => "example-elasticsearch",
        installdir => "/srv/elasticsearch",
    }


Once installed onto your node(s), you can access the elasticsearch web interface here;

http://serverhostname:9200/

and the elasticsearch-head interface here;

http://serverhostname:9200/_plugin/head/

Copyright (C) 2013 Craig Parker craig@paragon.net.uk

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; If not, see http://www.gnu.org/licenses/

Orginal installation guide followed is here - http://ptylr.com/2013/06/03/installing-configuring-an-elasticsearch-cluster-in-centos-6/


