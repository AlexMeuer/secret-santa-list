FROM golang:1.16 as builder

# Create and change to the app directory.
WORKDIR /app

# Retrieve application dependencies.
COPY go.* ./
RUN go mod download

# Copy local code to the container image.
COPY . ./

# Build the binary.
RUN CGO_ENABLED=0 GOOS=linux go build -mod=readonly -v -o secret-santa-list main.go


FROM alpine:3
RUN apk add --no-cache ca-certificates

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/secret-santa-list /bin/secret-santa-list

# Run the web service on container startup.
CMD ["/bin/secret-santa-list", "serve", "gql"]

