#! /bin/bash
echo "elasticsearch.hosts: ['http://${internal_lb_ip}:9200']" >> /etc/kibana/kibana.yml
echo "server.name: ${kibana_server_name}" >> /etc/kibana/kibana.yml
echo "server.host: 0.0.0.0" >> /etc/kibana/kibana.yml
echo "server.port: ${kibana_port}" >> /etc/kibana/kibana.yml
echo "kibana.index: .kibanana" >> /etc/kibana/kibana.yml
echo "logging.verbose: true" >> /etc/kibana/kibana.yml

