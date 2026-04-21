#!/bin/sh

perl -E '($s,$z,$f)=@ARGV;$g=(length $s)%$z;$s.=$f x($g&&$z-$g);say join q{, },unpack("(A$z)*",$s)' "$@"
