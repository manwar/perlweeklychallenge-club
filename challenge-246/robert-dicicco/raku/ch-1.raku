#!/usr/bin/env raku
=begin comment
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-12-06
Challenge 246 6 Out of 49  ( Raku )
-------------------------------------
=end comment

use v6;

my $cnt = 0;
my @out = ();
while 1 == 1 {
    my $num = 49.rand.Int;
    if $num > 0 {
        @out.push: $num;
        $cnt++;
    }
    last if $cnt == 6;
}
say @out.sort;

=begin comment
-------------------------------------
SAMPLE OUTPUT
(3 15 25 27 29 42)
-------------------------------------
=end comment
