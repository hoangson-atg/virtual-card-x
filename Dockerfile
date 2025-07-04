# Build stage
FROM golang:1.22.3-alpine AS builder

WORKDIR /app

COPY go.mod ./  
COPY go.sum ./  
RUN go mod download

COPY . ./

RUN go build -o main .

# Run stage
FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/main .

EXPOSE 8080

CMD ["./main"]