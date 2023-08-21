#!/usr/bin/env raku
=begin comment
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-14
Challenge 230 Separate Digits  Task 1 ( Raku )
-----------------------------------
=end comment
use v6;
my @myints = ([1, 34, 5, 6], [1, 24, 51, 60]);

for (@myints) -> @ints {
    my $str = '';
    say "Input: \@ints = ",@ints;
    for (@ints) -> $digit  {
        $str ~= $digit;
    }
    my @arr = (split("",$str));
    say "Output: ",@arr,"\n";
}

=begin comment
-----------------------------------
SAMPLE OUTPUT
raku .\SeperateDigits.rk

Input: @ints = [1 34 5 6]
Output: [ 1 3 4 5 6 ]

Input: @ints = [1 24 51 60]
Output: [ 1 2 4 5 1 6 0 ]
-----------------------------------
=end comment


