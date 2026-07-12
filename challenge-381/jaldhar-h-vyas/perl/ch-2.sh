#!/bin/sh

perl -E 'my@a=sort{$a<=>$b}@ARGV;say scalar grep{$_!=$a[0]&&$_!=$a[-1]}@a' "$@"
