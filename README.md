Docker image to support Gradle builds for Kotlin Native and Multiplatform projects.

## Motivation
The goal of this Docker image is to provide an easy way to build Kotlin Native and Multiplatform apps in a Continous Integration environment.

The functionality provided in this image is based uppon the work of:
* [andyneff](https://github.com/andyneff/wine_msys64)
* [soywiz](https://github.com/soywiz/docker-wine-openjdk-gradle-kotlin-native)

## Currently supported [build targets](https://kotlinlang.org/docs/reference/building-mpp-with-gradle.html#supported-platforms):
* mingwX64
* linuxX64

## How to use
### [Example Bash script](gradlew_win) to build a Windows executable which needs the libcurl MSYS2 package during linking
```bash
#!/bin/bash
docker run --rm --cap-add SYS_PTRACE \
           -v "$PWD:/work:delegated" \
           -v docker-kotlin-native-mp_wine-home:/home/.user_wine \
           -e USER_ID=`id -u` \
           -e TARGETS='mingwX64' \
      	   -e MSYS2_PACKAGES='mingw-w64-x86_64-curl' \
           thowimmer/kotlin-native-multiplatform:latest \
           root -c "gosu user wineconsole gradlew.bat --no-daemon $*"
```

### [Example Bash script](gradlew_linux) to build a Linux executable which needs the libcurl APT package during linking
```bash
#!/bin/bash
docker run --rm --cap-add SYS_PTRACE \
           -v "$PWD:/work:delegated" \
           -v docker-kotlin-native-mp_linux-home:/root \
           -v docker-kotlin-native-mp_linux-usr:/usr \
           -e USER_ID=`id -u` \
           -e TARGETS='linuxX64' \
           -e APT_PACKAGES='libcurl4-openssl-dev' \
           thowimmer/kotlin-native-multiplatform \
           root -c "gosu user ./gradlew --no-daemon $*"
```

### Environment variables
#### TARGETS environment variable
Semicolon separated list of supported build targets.

#### MSYS2_PACKAGES environment variable
Semicolon separated list of MSYS2 packages to install during initial setup. Only relevant for build target **mingwX64**.

#### APT_PACKAGES environment variable
Semicolon separated list of APT packages to install during initial setup. Only relevant for build target **linuxX64**.

### Additional notes
* All relevant dependencies will be downloaded and persisted in the Docker volumes during the first build execution for a specific target. Therefore subsequent builds will be significantly faster.

* A build is not limited to single target. This means that you can adapt the *docker run* command with the required environment variables and command line arguments accordingly to execute a build for multiple targets.
