#!/bin/sh

raku -e '@*ARGS.combinations(2).map({ @$_[0] +^ @$_[1] }).sort({ $^b <=> $^a }).first.say;' $@
