#!/bin/sh

 raku -e 'say @*ARGS[0].split(q{,})∩@*ARGS[1].split(q{,})==∅??1!!0' $@
