#!/bin/bash

cd /opt/solr/bin

#precreate-core vertex_index   /opt/solr/server/solr/configsets/atlas/
#precreate-core edge_index     /opt/solr/server/solr/configsets/atlas/
#precreate-core fulltext_index /opt/solr/server/solr/configsets/atlas/

./solr zk upconfig -n vertex_index -d /opt/solr/server/solr/configsets/atlas/
./solr zk upconfig -n edge_index -d /opt/solr/server/solr/configsets/atlas/
./solr zk upconfig -n fulltext_index -d /opt/solr/server/solr/configsets/atlas/
./solr zk upconfig -n atlas -d /opt/solr/server/solr/configsets/atlas/

