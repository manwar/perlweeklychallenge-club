#!/bin/sh

perl -E 'my @a=map{y/a-j/0-9/;$_}@ARGV[0..2];say $a[0]+$a[1]==$a[2]?"true":"false"' "$@"
