#!/usr/bin/perl
# The Weekly Challenge #080 Task 2 Count Candies
use strict;
use warnings;
#use Test::More tests => 7;
use List::Util qw/sum/;
use feature qw/say/; 

my @N;
if ($ARGV[0]) {@N = @ARGV;} else {@N = (1, 2, 2)};

sub rule_two {
    my $change = undef;
    my @rank = @{$_[0]};
    my @candies = @{$_[1]};

    if ($rank[0] > $rank[1] and $candies[0] <= $candies[1]) {
        $candies[0]++;
        $change = 1;
    }

    for (1..$#rank-1) {
        if (($candies[$_] <= $candies[$_-1] && $rank[$_] > $rank[$_-1] ) ||
           ($candies[$_] <= $candies[$_+1] && $rank[$_] > $rank[$_+1] ) ) {
             $candies[$_]++;
             $change = 1;
        }
    }

    if (  $rank[$#rank] > $rank[$#rank-1] and 
          $candies[$#rank] <= $candies[$#rank-1]) {
        $candies[$#rank]++;
        $change = 1;
    }

    return ($change,@candies);
}

sub countcandies {
    my @rank = @_;
    my $bool_ctd;
    my @candies = (1) x scalar @rank;  #apply rule 1
    do {                               #apply rule 2 in loop
        ($bool_ctd,@candies) = rule_two(\@rank, \@candies);
    } while ($bool_ctd);
    return sum @candies;
}

say countcandies(@N);

=pod
ok countcandies(1, 2, 2) == 4, "pass test case Example 1";
ok countcandies(1, 4, 3, 2) == 7, "pass test case Example 2";
ok countcandies(1, 2, 3) == 6, "pass test case 1 2 3";
ok countcandies(5, 2, 2, 1) == 6, "pass test case 2";
ok countcandies(1, 8, 1) == 4, "pass test case 3";
ok countcandies(2, 1, 1) == 4, "pass test case 4";
ok countcandies(1, 6, 7, 28, 5, 1, 2, 3) == 18, "pass test case 5";
=cut
