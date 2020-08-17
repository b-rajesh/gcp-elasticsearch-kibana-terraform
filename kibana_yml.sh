#! /bin/bash
cat <<EOT >> /etc/kibana/kibana.yml
elasticsearch.hosts: ['https://${internal_lb_ip}:9200']
server.name: ${kibana_server_name}
server.host: ${kibana_ip_address}
server.port: ${kibana_port}
kibana.index: .kibanana
logging.dest: /var/log/kibana.log
logging.verbose: true
EOT
