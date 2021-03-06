FROM golang:1.11.5

LABEL maintainer="jblaskowich@gmail.com"

WORKDIR /

RUN go get -v -d github.com/nats-io/go-nats

RUN go get -v -d github.com/gorilla/mux

RUN go get -v -d github.com/prometheus/client_golang/prometheus/promhttp

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch  

COPY --from=0 app /

COPY templates templates/

COPY static static/

ENTRYPOINT ["/app"]