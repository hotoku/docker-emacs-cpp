FROM alpine:3.14.0

RUN apk update && \
    apk add \
    emacs \
    tmux

RUN apk add git
RUN apk add openssh


ARG bazel_ver=1.0.0

ENV JAVA_HOME=/usr/lib/jvm/default-jvm \
    PATH="$JAVA_HOME/bin:${PATH}" \
    BAZEL_VERSION=1.0.0


RUN apk add --virtual .bazel_build --no-cache g++ gcc \
  bash zip unzip cmake make linux-headers openjdk8 && \
  wget -q "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-dist.zip" \
  -O bazel.zip && \
  mkdir "bazel-${BAZEL_VERSION}" && \
  unzip -qd "bazel-${BAZEL_VERSION}" bazel.zip && \
  rm bazel.zip && \
  cd "bazel-${BAZEL_VERSION}" && \
  sed -i -e '/#endif  \/\/ _WIN32/{h;s//#else/;G;s//#include <sys\/stat.h>/;G;}' third_party/ijar/common.h && \
  sed -i -e 's/-classpath/-J-Xmx6096m -J-Xms128m -classpath/g' scripts/bootstrap/compile.sh 

RUN cd "bazel-${BAZEL_VERSION}" && \
    EXTRA_BAZEL_ARGS=--host_javabase=@local_jdk//:jdk ./compile.sh

RUN cp -p output/bazel /usr/bin/ && \
  cd ../ && rm -rf "bazel-${BAZEL_VERSION}" && \
  bazel version && \
  apk del --purge .bazel_build


WORKDIR /root
