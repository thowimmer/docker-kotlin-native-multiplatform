FROM andyneff/wine_msys64:ubuntu_16.04

# Add custom entrypoint script
ADD setup_entrypoint.bsh /
RUN chmod 755 /setup_entrypoint.bsh

# Install custom dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates wget unzip

ENTRYPOINT ["/wine_entrypoint.bsh", "--add", "/setup_entrypoint.bsh"]

#Set work directory
VOLUME ["/work"]
WORKDIR /work
