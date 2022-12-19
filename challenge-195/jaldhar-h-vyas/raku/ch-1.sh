#!/bin/sh

raku -e '(1 .. @*ARGS[0]).grep({ my @digit = $_.comb; @digits ~~ @digits.unique; }).elems.say;' $@