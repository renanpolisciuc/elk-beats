#!/bin/sh

echo "Wait for kibana"
./wait-for-it.sh kibana:5601 -s -t 0

KIBANA_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" http://kibana:5601/api/status)
echo "Kibana status: $KIBANA_STATUS"
while [ "$KIBANA_STATUS" != "200"  ]; do
    KIBANA_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" http://kibana:5601/api/status)
    echo "Kibana status: $KIBANA_STATUS"
    sleep 2
done

echo "Start metricbeat"
service metricbeat start > /dev/null 2>&1 &


echo "Start filebeat"
service filebeat start > /dev/null 2>&1 &

echo "Start heartbeat"
service heartbeat-elastic start > /dev/null 2>&1 &

echo "Start packetbeat"
service packetbeat start > /dev/null 2>&1 &

echo "Run nginx"
nginx -g "daemon off;"