FROM alpine:3.4

#add ruby and bundler
RUN apk add --no-cache ruby ruby-bigdecimal ruby-irb ruby-bundler bash
