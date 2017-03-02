FROM wernight/phantomjs:latest

# get default user
# RUN id -u -n

USER root
# RUN wget https://github.com/wavedrom/cli/archive/master.zip
RUN apt-get -y update && apt-get -y install git-core npm
USER phantomjs
RUN cd /home/phantomjs && mkdir wavedrom-cli
RUN git clone https://github.com/wavedrom/cli.git /home/phantomjs/wavedrom-cli

# RUN cd cli
USER root
RUN npm install wavedrom-cli --save-dev
USER phantomjs

CMD phantomjs ./node_modules/wavedrom-cli/bin/wavedrom-cli.js
