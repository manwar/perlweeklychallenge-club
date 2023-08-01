#!/usr/bin/env perl
=begin comment
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-01
Challenge 228 Task 2 Empty Array ( Perl )
---------------------------------------
=cut
use v5.38;
use List::Util qw/min/;

my @myints = ([3, 4, 2],[1,2,3]);

for my $i (@myints) {
    say "Input: \@int = (@$i)";
    my $cnt = 0;
    while(scalar @$i) {
        my $min = min(@$i);
        if ($i->[0] == $min) {
            shift(@$i);
        } else {
            push(@$i,$i->[0]);
            shift(@$i);
        }
        scalar @$i > 0 ? say "(@$i)" : say "()";
        $cnt++;
    }
    say "Output: $cnt\n";
}

=begin comment
---------------------------------------
SAMPLE OUTPUT
perl .\EmptyArray.pl

Input: @int = (3 4 2)
(4 2 3)
(2 3 4)
(3 4)
(4)
()
Output: 5

Input: @int = (1 2 3)
(2 3)
(3)
()
Output: 3
---------------------------------------
=cut




