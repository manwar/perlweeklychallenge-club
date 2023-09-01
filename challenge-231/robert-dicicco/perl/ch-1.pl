#!/usr/bin/env perl
=begin
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-21
Challenge 231 Min Max Task 1 ( Perl )
----------------------------------------
=cut

use v5.38;
use List::Util qw/min max/;

my @myints = ([3, 2, 1, 4],[3, 1],[2, 1, 3]);

for my $ints (@myints) {
    say "Input: \@ints = \( @$ints \)";
    print("Output: ");
    if (scalar (@$ints) <= 2 ) {
        say "-1\n";
        next;
    }
    my $min = min(@$ints);
    my $max = max(@$ints);
    print("( ");
    for my $i (@$ints) {
        print("$i ") if ($i > $min and $i < $max);
    }
    say ")\n";
}

=begin
----------------------------------------
SAMPLE OUTPUT
perl .\MinMax.pl

Input: @ints = ( 3 2 1 4 )
Output: ( 3 2 )

Input: @ints = ( 3 1 )
Output: -1

Input: @ints = ( 2 1 3 )
Output: ( 2 )
----------------------------------------
=cut


