#!/bin/sh

perl -E '$_=$ARGV[0];say $_/2+($_%2?0.5:0)' "$@"
