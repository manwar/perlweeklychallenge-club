#!/bin/sh

perl -E 'say [sort {$b<=>$a} map {scalar @{[split q{ }]}} @ARGV]->[0]' "$@"
