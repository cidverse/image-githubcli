# custom build
FROM golang:1.16-alpine

ENV VERSION "1.11.0"

RUN apk add --no-cache curl &&\
	curl -L -o /tmp/src.zip https://github.com/cli/cli/archive/refs/tags/v${VERSION}.zip &&\
	unzip /tmp/src.zip -d /tmp/src &&\
	cd /tmp/src/cli-${VERSION} &&\
	go build -o /usr/local/bin/gh -ldflags "-s -w" /tmp/src/cli-${VERSION}/cmd/gh

# Base
FROM alpine:latest

# Update Deps
RUN apk add --no-cache git

# Installation
COPY --from=0 /usr/local/bin/gh /usr/local/bin/gh
