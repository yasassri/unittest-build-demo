FROM wso2/wso2mi:1.2.0

ARG WSO2_USER=wso2carbon
ARG WSO2_USER_ID=802

USER root
RUN apk add --no-cache curl tar bash procps zip     

# Define the SHA key to validate the maven download
ARG SHA=c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0

# Define the URL where maven can be downloaded from
ARG BASE_URL=https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

COPY init.sh /usr/local/bin/init.sh

# Create the directories, download maven, validate the download, install it, remove downloaded file and set links
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && echo "Downlaoding maven" \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL} \
  \
  && echo "Checking download hash" \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  \
  && echo "Unziping maven" \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  \
  && echo "Cleaning and setting links" \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
  && chmod +x /usr/local/bin/init.sh

# Define Maven home env variables
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME/.m2"

ENTRYPOINT ["/usr/local/bin/init.sh"]
