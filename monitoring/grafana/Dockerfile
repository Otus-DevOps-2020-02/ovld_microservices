FROM grafana/grafana:7.0.1

ADD datasources.yaml /etc/grafana/provisioning/datasources/
ADD dashboards.yaml /etc/grafana/provisioning/dashboards/
COPY dashboards/* /etc/grafana/provisioning/dashboards/
