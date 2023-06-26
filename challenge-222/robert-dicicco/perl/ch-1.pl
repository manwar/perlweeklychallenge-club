#!/usr/bin/env perl
=begin comment
-----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-19
Challenge 222 Task 1 Matching Members ( Perl )
-----------------------------------------------
=cut
use strict;
use warnings;
use feature 'say';

my @allints = ([1, 1, 4, 2, 1, 3],[5, 1, 2, 3, 4],[1, 2, 3, 4, 5]);

for my $ints (@allints) {
    my $flag = 0;
    my @original = @$ints;
    say "Input: \@ints = \(",join(",",@original),"\)";
    my @sorted = sort(@original);
    my $cnt = scalar (@original);
    for (my $digit=0; $digit < $cnt; $digit++){
        if ($original[$digit] == $sorted[$digit]) {
            $flag++;
        }
    }
    say "Output: $flag\n";
}

=begin comment
-----------------------------------------------
SAMPLE OUTPUT
perl .\MatchingMembers.pl

Input: @ints = (1,1,4,2,1,3)
Output: 3

Input: @ints = (5,1,2,3,4)
Output: 0

Input: @ints = (1,2,3,4,5)
Output: 5
-----------------------------------------------
=cut


