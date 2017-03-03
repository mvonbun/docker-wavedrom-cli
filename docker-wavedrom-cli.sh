#!/usr/bin/env bash

### main function
function dockerrun {
    # dockerrun indir infile outdir outfile
    FORMATVALID=false
    echo "convert: $1/$2 -> $3/$4" &>$Q
    if [[ "$4" == *.svg ]]; then
	FORMATVALID=true
	echo "docker run -v $1:/data mvonbun/docker-wavedrom-cli -i $2 -s $4"  &>$V
	docker run -v "$1:/data" mvonbun/docker-wavedrom-cli -i "$2" -s "$4"
    fi
    if [[ "$4" == *.png ]]; then
	FORMATVALID=true
	echo "docker run -v $1:/data mvonbun/docker-wavedrom-cli -i $2 -p $4"  &>$V
	docker run -v "$1:/data" mvonbun/docker-wavedrom-cli -i "$2" -p "$4"
    fi
    if [[ "$4" == *.pdf ]]; then
	FORMATVALID=true
	echo "docker run -v $1:/data mvonbun/docker-wavedrom-cli -i $2 -p $4"  &>$V
	docker run -v "$1:/data" mvonbun/docker-wavedrom-cli -i "$2" -p "$4"
    fi

    if [ "$FORMATVALID" = true ]; then
	if [ "$1" != "$3" ]; then
	    echo "mv $1/$4 $3/$4" &>$V
	    # mv "$1/$4" "$3/$4"
	fi
    else
	echo "Unknown output format $4. No output generated."
    fi
}


### get script names
thisScript=${0##*/}
thisScriptBasename=${thisScript%%.*}


### user interface
## option defaults
HELP=false
QUIET=false
VERBOSE=false
OUTPUTVAL=pdf
USEOUTDIR=false

## option parsing
while [[ "$1" == -* ]]; do
    case "$1" in
        -h | --help)
	    HELP=true;;
	-q | --quiet)
	    QUIET=true;;
        -v | --verbose)
	    VERBOSE=true;;
	-f | --format)
	    OUTPUTVAL="$2"; shift;;
	-d | --dir)
	    USEOUTDIR="$2"; shift;;
    esac
    shift
done

## set user notification levels
# verbosity
if [ "$VERBOSE" = true ]; then
    V=/dev/stdout
else
    V=/dev/null
fi
# quiet
if [ "$QUIET" = true ]; then
    Q=/dev/null
else
    Q=/dev/stdout
fi

## help
if [ "$HELP" = true ]; then
    echo "$thisScriptBasename [options] input-file(s) [output-file]"
    echo "Generate waveforms using wavedrom from file."
    echo ""
    echo "Options:"
    echo "   -f/--format (pdf/png/svg)   specify output format [default: pdf]"
    echo "   -d/--dir (directory)        specify output directory [default: same as input file]"
    echo ""
    echo "   -h/--help                   show this help text"
    echo "   -q/--quiet                  disable basic status messages"
    echo "   -v/--verbose                enable verbosity"
    echo ""
    echo "Examples converting single files:"
    echo "   $thisScriptBasename /mypath/mywave.json"
    echo "   Output is /mypath/mywave.pdf."
    echo ""
    echo "   $thisScriptBasename /mypath/mywave.json /myOtherPath/myNicewave.png"
    echo "   Output is /myOtherPath/myNicewave.png"
    echo ""
    echo "Examples for batch processing multiple files:"
    echo "   $thisScriptBasename /mypath/mywave01.json /mypath/mywave02.json"
    echo "   Output is /mypath/mywave01.pdf /mypath/mywave02.pdf."
    echo ""
    echo "   $thisScriptBasename -o svg /mypath/mywave01.json /mypath/mywave02.json"
    echo "   Output is /mypath/mywave01.svg /mypath/mywave02.svg."
    echo ""
    echo "   $thisScriptBasename -o svg -d ""/somepath"" /mypath/mywave01.json /mypath/mywave02.json"
    echo "   Output is /somepath/mywave01.svg /somepath/mywave02.svg."
    echo ""
    exit
fi


### process remaining arguments
## option defaults
SINGLEFILE=false
OUTDIR="$USEOUTDIR"
if [ $# -gt 0 ]; then
    # handling of 2 inputs:
    # could be INPUT OUTPUT => single file
    # could be INPUT1 INPUT2 => two files
    if [ $# -eq 2 ]; then
	if [[ "$2" == *.pdf ]] || [[ "$2" == *.png ]] || [[ "$2" == *.svg ]]; then
	    SINGLEFILE=true
	fi
    fi

    # file processing
    if [ "$SINGLEFILE" = true ]; then
	# absulute paths
	INDIR=$(cd "$(dirname "$1")"; pwd)
	INFILE=${1##*/}
	[ "$OUTDIR" = false ] && OUTDIR=$(cd "$(dirname "$2")"; pwd)
	OUTFILE=${2##*/}
	# run docker container
	dockerrun "$INDIR" "$INFILE" "$OUTDIR" "$OUTFILE"
    else
	# do for every file
	for ARG in "$@"; do
	    # absulute paths
	    INDIR=$(cd "$(dirname "$ARG")"; pwd)
	    INFILE=${ARG##*/}
	    OUTFILEBASE=${INFILE%%.*}
	    [ "$USEOUTDIR" = false ] && OUTDIR="$INDIR"
	    # run docker container
	    dockerrun "$INDIR" "$INFILE" "$OUTDIR" "$OUTFILEBASE.$OUTPUTVAL"
	done
    fi
else
    echo "No input file specified"
    exit 1
fi

