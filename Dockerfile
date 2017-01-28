FROM alpine:latest

# Signal what init script trap for graceful stop
STOPSIGNAL SIGTERM

# Use the app name for init script work
ENTRYPOINT ["/bin/init", "cbapp"]

# Triggers for child image build for Chicago Boss project
ONBUILD WORKDIR /opt/cbapp
ONBUILD COPY . /opt/cbapp
ONBUILD RUN rebar compile

# Install Rebar3 and the init script
ADD https://s3.amazonaws.com/rebar3/rebar3 /bin/rebar
COPY init.sh /bin/init

# Metadata of image
LABEL maintainer="jhg.jesus@gmail.com"
LABEL description="Base for run Chicago Boss"

# Metadata of image from build
ARG version
LABEL version="$version"
# Install latest version of Erlang and last steps
RUN apk add --no-cache erlang && \
    chmod +x /bin/rebar && \
    ln -s /bin/rebar /bin/rebar3 && \
    chmod +x /bin/rebar3 && \
    chmod +x /bin/init
