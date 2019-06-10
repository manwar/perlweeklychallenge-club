#!/usr/bin/env perl6
my $s=@*ARGS[0]//10;
(([1,|(0 xx $s-1)].rotate: -$++)  xx $s).map: *.join(" ").say;

