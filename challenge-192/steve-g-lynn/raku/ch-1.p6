#!/usr/bin/env perl6

say &binary-flip(5); #2
say &binary-flip(4); #3
say &binary-flip(6); #1

sub binary-flip (Int $n) {
    my $b=sprintf("%b",$n);
    $b ~~ tr/<[1 0]>/<[0 1]>/;
    +('0b' ~ $b);
}
