#!/usr/bin/env perl
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-28
Challenge 210 Kill&Win ( Perl )
--------------------------------------
=cut
use strict;
use warnings;
use feature 'say';
use List::Util 'sum';

my @int = ([2,3,1],[1,1,2,2,2,3]);
my $total_score = 0;
my $max_score = 0;
my $max_possible = 0;

sub Score {
    my $a = shift;

    for my $testx (@$a) {
        say "trying $testx...";

        for my $val (@$a) {
            $total_score += $val if (($val == $testx) || ($val == $testx-1) || ($val == $testx+1));
        }

        if ($total_score == $max_possible) {
            say "Output: $total_score\n";
            return;
        }
        if ($total_score > $max_score) {
            $max_score = $total_score;
        }

        $total_score = 0;
     }
     say "Output: $max_score\n";
}

for my $i (@int) {
    my @arr = @$i;
    say "Input: \@int = (@arr)";
    $max_possible = sum(@arr[0..$#arr]);
    say "max_possible = $max_possible";
    Score(\@arr);
}
=begin comment
--------------------------------------
SAMPLE OUTPUT
perl .\KillWin.pl
Input: @int = (2 3 1)
max_possible = 6
trying 2...
Output: 6

Input: @int = (1 1 2 2 2 3)
max_possible = 11
trying 1...
trying 1...
trying 2...
Output: 11
--------------------------------------
=cut


