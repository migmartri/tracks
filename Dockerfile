## BUILDING
##   (from project root directory)
##   $ docker build -t migmartri-tracks .
##
## RUNNING
##   $ docker run -p 3000:3000 migmartri-tracks
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:3000
##     replacing DOCKER_IP for the IP of your active docker host
##
## NOTES
##   Ensure the version of Rails in your app's Gemfile matches 4.2.6

FROM gcr.io/stacksmith-images/debian-buildpack:wheezy-r07

MAINTAINER Bitnami <containers@bitnami.com>

LABEL com.bitnami.stacksmith.id="pzfs8hf" \
      com.bitnami.stacksmith.name="migmartri/tracks"

ENV STACKSMITH_STACK_ID="pzfs8hf" \
    STACKSMITH_STACK_NAME="migmartri/tracks" \
    STACKSMITH_STACK_PRIVATE="1"

# Runtime
RUN bitnami-pkg install ruby-2.3.1-1 --checksum a81395976c85e8b7c8da3c1db6385d0e909bd05d9a3c1527f8fa36b8eb093d84

# Framework
RUN bitnami-pkg install rails-4.2.6-0 --checksum b4ec5946457919f380a43cd633ad3bb37046bb0609937439111fb56c30acc917

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Runtime template
ENV PATH=/opt/bitnami/ruby/bin:$PATH

COPY . /app
RUN chown -R bitnami:bitnami /app
USER bitnami
WORKDIR /app

RUN bundle install

EXPOSE 3000
CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "3000"]
