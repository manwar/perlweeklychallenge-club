#!/bin/sh

raku -e '$_=@*ARGS[0];while s/(.)$0// {};.say' "$@"