#! /opt/local/bin/perl
#
#     your_pasta_lies_add_up.pl
#
#     TASK #1 › Fibonacci Sum
#     Submitted by: Mohammad S Anwar
#     You are given a positive integer $N.
# 
#     UPDATE: 2020-09-07 09:00:00
#     Write a script to find out all possible combination of Fibonacci Numbers
#     required to get $N on addition.
# 
#     You are NOT allowed to repeat a number. Print 0 if none found.
# 
# 
#     Example 1:
#         Input: $N = 6
#     
#         Output: 3 as (1 + 2 + 3 = 6)
# 
#     Example 2:
#         Input: $N = 9
#     
#         Output: 2 as (1 + 8 = 9)
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);

## ## ## ## ## MAIN:

my ($target) = shift @ARGV // 9998;

## make a fib sequence up to the target
my @fib = (0,1);
while (1) {
    push @fib,  $fib[-1]  + $fib[-2];
    last if $fib[-1]  + $fib[-2] > $target;
}
## remove 0, remove extra 1
splice @fib,  0, 2;

## work
my @output;
for my $len (1..@fib) {
    my $iter = combinations( \@fib, $len );
    while ( my $c = $iter->next ) {
        push @output, join " + ", @$c if sum( @$c ) == $target;
    }
}

## out
say "target: $target";
say "found ", scalar @output, " solutions:\n";

say "\t$_" for (sort @output );
