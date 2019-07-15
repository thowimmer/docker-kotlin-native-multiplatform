FROM andyneff/wine_msys64:ubuntu_16.04

# Add custom entrypoint script
ADD setup_entrypoint.bsh
RUN chmod 755 /setup_entrypoint.bsh

# Install custom dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates wget unzip

# Download and unpack ojdkbuild JDK8 to Wine home
RUN mkdir -p /home/wine/drive_c/dev/ && \
    cd /home/wine/drive_c/dev/ && \
    wget https://github.com/ojdkbuild/ojdkbuild/releases/download/1.8.0.212-1/java-1.8.0-openjdk-1.8.0.212-1.b04.ojdkbuild.windows.x86.zip && \
    unzip java-1.8.0-openjdk-1.8.0.212-1.b04.ojdkbuild.windows.x86.zip && \
    rm -rf java-1.8.0-openjdk-1.8.0.212-1.b04.ojdkbuild.windows.x86.zip && \
    mv java-1.8.0-openjdk-1.8.0.212-1.b04.ojdkbuild.windows.x86 java
    
ENTRYPOINT ["/wine_entrypoint.bsh", "--add", "/setup_entrypoint.bsh"]

#Set work directory
VOLUME ["/work"]
WORKDIR /work
