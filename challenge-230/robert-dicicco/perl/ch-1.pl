#!/usr/bin/env perl
=begin comment
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-14
Challenge 230 Separate Digits  Task 1 ( Perl )
-----------------------------------
=cut
use v5.38;

my @myints = ([1, 34, 5, 6], [1, 24, 51, 60]);


for my $ints (@myints) {
    my $str = '';
    say "Input: \@ints = (@$ints)";
    for my $digit (@$ints) {
        $str .= $digit;
    }
    my @arr = (split("",$str));
    say "Output: (@arr)\n";
}
=begin comment
-----------------------------------
SAMPLE OUTPUT
perl .\SeperateDigits.pl

Input: @ints = (1 34 5 6)
Output: (1 3 4 5 6)

Input: @ints = (1 24 51 60)
Output: (1 2 4 5 1 6 0)
-----------------------------------
=cut




