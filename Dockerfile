################
# BUILD BINARY #
################
# golang alpine 1.12
FROM golang@sha256:8cc1c0f534c0fef088f8fe09edc404f6ff4f729745b85deae5510bfd4c157fb2 as builder


# Install git + SSL ca certificates.
# Git is required for fetching the dependencies.
# Ca-certificates is required to call HTTPS endpoints.
RUN apk update && apk add --no-cache git tzdata

WORKDIR $GOPATH/src/gotest
COPY . .

RUN echo $PWD && ls -la

# Fetch dependencies.
RUN go get -d -v

#CMD go build -v
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -installsuffix cgo -o /go/bin/gotest .

#####################
# MAKE SMALL BINARY #
#####################
FROM alpine:3.7

RUN apk update

# Import from builder.
# COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
# COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
# COPY --from=builder /etc/passwd /etc/passwd

# Copy the executable.
COPY --from=builder /go/bin/gotest /go/bin/gotest
# COPY --from=builder /go/src/dbo_order/config.json /go/bin/config.json

#ENTRYPOINT ["/go/bin/dbo_order", "-conf", "/go/bin/config.json"]
