#!/bin/sh

perl -e 'for (eval ("0b".(0 x $ARGV[0]). ".." . "0b". (1 x $ARGV[0]))){printf("%b\n",$_)}' $@

