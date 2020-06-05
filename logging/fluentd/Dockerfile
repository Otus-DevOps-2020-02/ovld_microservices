FROM fluent/fluentd:v1.10.4-1.0
USER root

RUN gem install fluent-plugin-elasticsearch --no-document --version 4.0.9 && \
    gem install fluent-plugin-grok-parser --no-document --version 2.6.1
USER fluent
ADD fluent.conf /fluentd/etc
