#!/bin/sh

perl -E 'my@a=split//,join q{},@ARGV[0,1];say(((ord($a[0])+$a[1])%2==(ord($a[2])+$a[3])%2)?"true":"false")' "$@"
