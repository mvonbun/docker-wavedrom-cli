# docker-wavedrom-cli 
## Usage
docker run -v ~/Documents:/data mvonbun/docker-wavedrom-cli -i mywave.json -p mywave.pdf

to generate file *~/Documents/mywave.pdf* out of *~/Documents/mywave.json*.

## What is wavedrom

[http://wavedrom.com/](wavedrom) is an online editor for drawing
waveforms.

There is also an
[https://github.com/wavedrom/wavedrom.github.io/releases](offline
editor) available as well as a [https://github.com/wavedrom/cli](cli).

Using docker, there is no need for installing the required
[http://phantomjs.org/](PhantomJS) on the system just to get your
waveforms.

## wavedrom-cli options
-i <input wavedrom source filename>
-p file.png <output PNG image file name>
-p file.pdf <output PDF file name>
-s <output SVG image file name>








