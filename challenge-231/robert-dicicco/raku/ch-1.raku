#!/usr/bin/env raku
=begin comment
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-21
Challenge 231 Min Max Task 1 ( Raku )
----------------------------------------
=end comment
use v6;

my @myints = ([3, 2, 1, 4],[3, 1],[2, 1, 3]);


for (@myints) -> @ints {
    say "Input: \@ints = ",@ints;
    print("Output: ");
    if @ints.elems <= 2  {
        say "-1\n";
        next;
    }
    my $min = min(@ints);
    my $max = max(@ints);
    print("( ");
    for @ints -> $i {
        print("$i ") if ($i > $min and $i < $max);
    }
    say ")\n";
}

=begin comment
----------------------------------------
SAMPLE OUTPUT
raku .\MinMax.rk

Input: @ints = [3 2 1 4]
Output: ( 3 2 )

Input: @ints = [3 1]
Output: -1

Input: @ints = [2 1 3]
Output: ( 2 )
----------------------------------------
=end comment


