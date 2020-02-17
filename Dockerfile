FROM adoptopenjdk/openjdk11:jdk-11.0.6_10-alpine-slim

# USAGE:
#
# docker run -it --rm \
#    -e AWS_ACCESS_KEY_ID=XXX \
#    -e AWS_SECRET_ACCESS_KEY=XXX \
#    {IMAGE}
#
# git clone XXX
# cd XXX
# gradle build
# jig
# aws s3 sync build/jig XXX

RUN apk --no-cache add \
  git openssh curl graphviz font-noto python groff py-pip

RUN GRADLE_SHA256="9d94e6e4a28ad328072ef6e56bce79a810494ae756751fdcedffdeaf27c093b1" \
  && curl -LfsS https://services.gradle.org/distributions/gradle-6.1.1-bin.zip -o /tmp/gradle.bin.zip \
  && echo "${GRADLE_SHA256} */tmp/gradle.bin.zip" |  sha256sum -c - \
  && unzip -q /tmp/gradle.bin.zip -d /usr/local/share \
  && ln -sf /usr/local/share/gradle-6.1.1/bin/gradle /usr/bin/gradle \
  && mkdir /usr/local/share/jig \
  && curl -LfsS https://github.com/dddjava/jig/releases/latest/download/jig-cli.jar -o /usr/local/share/jig/jig-cli.jar \
  && curl https://bootstrap.pypa.io/get-pip.py | python \
  && pip install awscli \
  && rm /tmp/gradle.bin.zip \
  && apk del --purge py-pip \
  && rm -rf /root/.cache

RUN echo 'java -jar /usr/local/share/jig/jig-cli.jar'> /usr/bin/jig \
  && chmod +x /usr/bin/jig

CMD ["sh"]

