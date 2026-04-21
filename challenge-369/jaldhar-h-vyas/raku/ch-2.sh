#!/bin/sh

raku -e 'my ($s,$z,$f)=@*ARGS;my $g=$s.chars%$z;$s~=$f x($g && $z-$g);$s.comb($z+0).join(q{, }).say' "$@"
