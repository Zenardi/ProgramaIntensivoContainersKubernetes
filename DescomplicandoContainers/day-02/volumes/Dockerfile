FROM golang:1.18 as buildando
WORKDIR /app
COPY . ./
RUN go mod init hello
RUN go build -o /app/hello

FROM alpine:3.15.9
COPY --from=buildando /app/hello /app/hello
ENV app="Hello from Descomplicando Containers!"
ARG GIROPOPS="strigus"
ENV GIROPOPS=$GIROPOPS
RUN echo "Argumento giropops: $GIROPOPS"

VOLUME [ "/app/dados" ]

CMD ["/app/hello"]