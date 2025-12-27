#!/bin/sh

perl -E 'say[sort{$b<=>$a}map{scalar split/\s+/}@ARGV]->[0]' "$@"
