FROM golang:1.22.7-alpine3.20 AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY ./cmd/simple-go-service ./cmd/simple-go-service
RUN go build -C ./cmd/simple-go-service -o /simple-go-service

FROM scratch
COPY --from=builder /simple-go-service /simple-go-service

EXPOSE 8080

CMD ["/simple-go-service"]