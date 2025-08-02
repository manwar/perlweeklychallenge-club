#!/bin/sh

raku -e '$_=@*ARGS[0];/(\w+)\W*$/;say $0.chars||0' "$@"
