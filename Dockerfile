FROM golang:1.20

WORKDIR /usr/src/app

COPY go.mod ./
COPY go.sum ./

RUN apt update && apt upgrade -y
RUN apt install ffmpeg -y

RUN go mod download
COPY . .

RUN go build -o 8mb

ENTRYPOINT [ "./8mb" ]

