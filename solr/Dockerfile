FROM solr:8

USER 0

# Copy Atlas collections config set
RUN  mkdir -p /opt/solr/server/solr/configsets/atlas/conf/lang
COPY ./config/solr/*.*       /opt/solr/server/solr/configsets/atlas/conf/
COPY ./config/solr/lang/*.* /opt/solr/server/solr/configsets/atlas/conf/lang/
RUN chown -R solr:solr /opt/solr/server/solr/configsets/atlas/
COPY solr.xml /opt/solr/server/solr/solr.xml
RUN chown solr:solr /opt/solr/server/solr/solr.xml

# Copy script that creates Atlas collections
COPY ./scripts/atlas-solr-create.sh /docker-entrypoint-initdb.d/

RUN mkdir -p /var/solr/data/index_data
RUN chown -R solr:solr /var/solr/data/index_data

EXPOSE 8983

USER solr
