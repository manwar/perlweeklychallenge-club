#!/bin/sh

perl -E '$_=join q{},@ARGV;say length[sort/([1]+)/g]->[-1]||0' "$@"
