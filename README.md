# docker-wavedrom-cli 
## Usage
**docker run -v ~/Documents:/data mvonbun/docker-wavedrom-cli -i mywave.json -p mywave.pdf**

to generate file **~/Documents/mywave.pdf** out of **~/Documents/mywave.json**.

## What is wavedrom

[wavedrom](http://wavedrom.com/) is an online editor for drawing
waveforms.

There is also an
[offline editor](https://github.com/wavedrom/wavedrom.github.io/releases)
available as well as a [cli](https://github.com/wavedrom/cli).

Using docker, there is no need for installing the required
[PhantomJS](http://phantomjs.org/) on the system just to get your
waveforms.

## wavedrom-cli options
-i <input wavedrom source filename>  
-p file.png <output PNG image file name>  
-p file.pdf <output PDF file name>  
-s <output SVG image file name>  








