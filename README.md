Docker image to support Gradle builds for Kotlin Native and Multiplatform projects.

## Motivation
The goal of this Docker image is to provide an easy way to build Kotlin Native and Multiplatform apps in a Continous Integration environment.

The functionality provided in this image is based uppon the work of:
* [andyneff](https://github.com/andyneff/wine_msys64) 
* [soywiz](https://github.com/soywiz/docker-wine-openjdk-gradle-kotlin-native)

## Currently supported [build targets](https://kotlinlang.org/docs/reference/building-mpp-with-gradle.html#supported-platforms):
* mingwX64
* linuxX64

## Bash scripts for platform builds
This repository also contains Bash scripts which can be put into the projects folder to execute platform specific builds.

### [gradlew_win]
Bash script which executes the gradlew.bat script in the container with the given arguments.

### [gradlew_linux]
Bash script which executes the gradlew script in the container with the given arguments.
