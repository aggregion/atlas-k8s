FROM aggregion/hadoop:latest


RUN mkdir -p /home/atlas

COPY ./scripts/atlas-hadoop-setup.sh             /home/atlas/scripts/
COPY ./scripts/atlas-hadoop.sh                   /home/atlas/scripts/
COPY ./scripts/atlas-hadoop-mkdir.sh             /home/atlas/scripts/

RUN mkdir -p /data /name
RUN chown -R hdfs:hadoop /data /name

ENTRYPOINT [ "/home/atlas/scripts/atlas-hadoop.sh" ]
