FROM node:alpine

LABEL maintainer="Ravi Lachhman"
LABEL org.label-schema.version=latest
LABEL org.label-schema.vcs-url="https://github.com/ravilach/drone-netlify"
LABEL org.label-schema.name="drone-netlify"
LABEL org.label-schema.description="Deploying to Netlify with Drone CI or Drone Compliant Plug-in Runners (Harness, Gitness)"
LABEL org.label-schema.vendor="Harness"
LABEL org.label-schema.schema-version="1.0"

RUN npm install -g netlify-cli

ADD script.sh /bin/
RUN chmod +x /bin/script.sh

ENTRYPOINT /bin/script.sh
