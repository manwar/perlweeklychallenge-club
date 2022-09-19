#!/bin/sh

raku -MBase::Any -e 'to-base(@*ARGS[0].Int, 2i).say;' $@