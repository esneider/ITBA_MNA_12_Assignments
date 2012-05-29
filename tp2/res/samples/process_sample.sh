#!/bin/bash

EXTENSION="jpg"

if [ $# != 2 ]; then

    echo "Usage:"
    echo "  ./process_sample.sh number_of_sample alpha"
    echo
    echo "  number_of_sample   should be an integer number such that the file"
    echo "                     sample_{number_of_sample}_in."$EXTENSION" is valid"
    echo "  alpha              alpha factor, should be a real number between 0.5 and 2"
    exit 1
fi

if [ ! -f "sample_"$1"_in."$EXTENSION ]; then

    echo "Invalid input file"
    exit 1
fi

IN_NAME="sample_"$1"_in."$EXTENSION
OUT_NAME="sample_"$1"_alpha_"$2"_out."$EXTENSION
DIFF_NAME="sample_"$1"_alpha_"$2"_diff."$EXTENSION
ZERO_NAME="sample_"$1"_alpha_"$2"_zeros.txt"

IN_NAME='"'$IN_NAME'"'
OUT_NAME='"'$OUT_NAME'"'
DIFF_NAME='"'$DIFF_NAME'"'

octave -q --eval "addpath(\"../../src\"); encode_and_decode("$IN_NAME","$OUT_NAME","$DIFF_NAME","$2")" > $ZERO_NAME

if [ $? -gt 0 ]; then

    echo "Error while processing file"
    exit 1
fi
