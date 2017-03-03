# docker-wavedrom-cli 
## Usage
### Pure Docker
**docker run -v ~/Documents:/data mvonbun/docker-wavedrom-cli -i mywave.json -p mywave.pdf**

to generate file **~/Documents/mywave.pdf** out of **~/Documents/mywave.json**.
	
### Bash Wrapper Script
**docker-wavedrom-cli.sh input output**  
**docker-wavedrom-cli.sh file1 file2 file3**  
**docker-wavedrom-cli.sh -f svg file1 file2 file3**  

## Wavedrom

[wavedrom](http://wavedrom.com/) is a convenient way for drawing waveforms.

The official resources for building waveforms include:  
 - [online editor](http://wavedrom.com/editor.html)  
 - [offline editor](https://github.com/wavedrom/wavedrom.github.io/releases)  
 - [command line interface (cli)](https://github.com/wavedrom/cli)

Using the cli, you can code offline (or use the online editor and copy
your code) and convert the result to either PDF, PNG, or SVG.  To use
the official cli, [PhantomJS](http://phantomjs.org/) is required on the
system.  Using docker, there is no need for installing PhantomJS just to
get your waveforms from the command line.

### wavedrom-cli options
**-i infile.json** *input wavedrom source filename*  
**-p outfile.png** *output PNG image file name*  
**-p outfile.pdf** *output PDF file name*  
**-s outfile.svg** *output SVG image file name*  

## Docker

"[Docker](https://www.docker.com/) is the world’s leading software
container platform [[1] (https://www\.docker\.com/what-docker)]




