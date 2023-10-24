#!/usr/bin/env perl
=begin comment
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 23-OCT-2023
Challenge 240 Task 02 Build Array ( Perl )
-----------------------------------
=cut
use v5.38;

my @myints = ([0, 2, 1, 5, 3, 4],[5, 0, 1, 2, 3, 4]);

for my $mints (@myints) {
    my @out = ();
    say "Input: \@ints = [@$mints]";
    for (my $cnt = 0; $cnt < scalar @$mints; $cnt++ ) {
        push(@out, $mints->[$mints->[$cnt]]);
    }
    say "Output: [@out]\n";
}

=begin comment
-----------------------------------
SAMPLE OUTPUT

perl .\BuildArray.pl

Input: @ints = [0 2 1 5 3 4]
Output: [0 1 2 4 5 3]

Input: @ints = [5 0 1 2 3 4]
Output: [4 5 0 1 2 3]
-----------------------------------
=cut


