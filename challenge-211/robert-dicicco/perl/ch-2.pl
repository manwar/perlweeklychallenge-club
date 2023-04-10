#!/usr/bin/env perl
=begin pod
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-09
Challenge 211 Split Same Average ( Perl )
----------------------------------------
=cut

use strict;
use warnings;
use feature 'say';
use Algorithm::Combinatorics qw(combinations);
use List::Util qw/sum/;

my @nums = (1,2,3,4,5,6,7,8);
#my @nums = (1,3);

my $flag = 0;
my %seen;     # lookup table
my @sec;    # answer

say "Input: \@nums = (@nums)";

if (scalar @nums <= 2) {
    say "Output: false";
    exit;
}

my $iter = combinations(\@nums, 4);
while (my $pn = $iter->next) {
    @sec = ();
    %seen = ();
    my $first = sum(@$pn) / scalar(@$pn);

    foreach my $item (@$pn) { $seen{$item} = 1 }

    foreach my $item (@nums) {
        push(@sec, $item) unless exists $seen{$item};
    }

    my $second = sum(@sec) / scalar @sec;
    if ($first == $second) { $flag = 1};
    say "-----> (@$pn),(@sec), $first : $second"  if $first == $second;
}

$flag == 1 ? (say "Output: true") : (say "Output: false");

=begin pod
----------------------------------------
SAMPLE OUTPUT
perl .\SplitSame.pl|more
Input: @nums = (1 2 3 4 5 6 7 8)
-----> (1 2 7 8),(3 4 5 6), 4.5 : 4.5
-----> (1 3 6 8),(2 4 5 7), 4.5 : 4.5
-----> (1 4 5 8),(2 3 6 7), 4.5 : 4.5
-----> (1 4 6 7),(2 3 5 8), 4.5 : 4.5
-----> (2 3 5 8),(1 4 6 7), 4.5 : 4.5
-----> (2 3 6 7),(1 4 5 8), 4.5 : 4.5
-----> (2 4 5 7),(1 3 6 8), 4.5 : 4.5
-----> (3 4 5 6),(1 2 7 8), 4.5 : 4.5
Output: true
 perl .\SplitSame.pl
Input: @nums = (1 3)
Output: false
----------------------------------------
=cut



