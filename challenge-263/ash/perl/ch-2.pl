# Solution to Task 2 of The Weekly Challenge 263
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/#TASK2

# $ perl ch-2.pl
# $VAR1 = [
#           [
#             1,
#             4
#           ],
#           [
#             2,
#             3
#           ],
#           [
#             3,
#             2
#           ]
#         ];

use v5.20;
use Data::Dumper;

my $items1 = [[1, 1], [2, 1], [3, 2]];
my $items2 = [[2, 2], [1, 3]];

my %values;
$values{$_->[0]} += $_->[1] for @$items1, @$items2;

my @result = map {[$_ + 0, $values{$_}]} sort {$a <=> $b} keys %values;

say Dumper(\@result);
