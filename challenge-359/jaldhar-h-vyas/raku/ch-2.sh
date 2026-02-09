#!/bin/sh

raku -e '$_=@*ARGS[0];while s:g/((.)$0)// {};.say' "$@"
