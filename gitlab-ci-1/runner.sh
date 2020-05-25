#!/bin/bash
TOKEN=$1
NAME=gitlab-runner-${RANDOM}
GITLAB_CI_URL="http://gitlab.vldops.club/"

mkdir -p /srv/$NAME/config
docker run -d --name $NAME --restart always -v /srv/$NAME/config:/etc/gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock gitlab/gitlab-runner:latest


docker exec -it $NAME gitlab-runner register \
  --run-untagged \
  --locked=false \
  --non-interactive \
  --url ${GITLAB_CI_URL} \
  --registration-token $TOKEN \
  --description "docker-runner" \
  --tag-list "linux,xenial,ubuntu,docker,vldops" \
  --executor docker \
  --docker-image "alpine:latest" \
  --docker-privileged \
  --docker-volumes "docker-certs-client:/certs/client" \
  --env "DOCKER_DRIVER=overlay2" \
  --env "DOCKER_TLS_CERTDIR=/certs"
