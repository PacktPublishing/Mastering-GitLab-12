FROM python:3.7-alpine

RUN apk add --no-cache \
    ca-certificates \
    git \
    wget

RUN wget https://s3.amazonaws.com/gitlab-runner-downloads/master/binaries/gitlab-runner-linux-386 && chmod +x gitlab-runner-linux-386 && \
 ./gitlab-runner-linux-386  register \
  --non-interactive \
  --url "https://gitlab-ee.joustie.nl/" \
  --registration-token "Vh6hpU1DUxKWfBtZw4U6" \
  --executor "shell" \
  --shell "sh" \
  --description "dockerized shell-runner" \
  --tag-list "docker" \
  --run-untagged="true" \
  --locked="false" 

ENTRYPOINT ["./gitlab-runner-linux-386","run"]
