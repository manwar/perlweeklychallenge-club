#!/bin/sh

perl -E 'say shift eq(join q{},map{substr $_, 0,1} @ARGV)?"true":"false"' "$@"
