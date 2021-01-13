#! /opt/local/bin/perl5.30
#
#       trail_of_zeros.pl
#
#         TASK #1 › Trailing Zeroes
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N (<= 10).
# 
#         Write a script to print number of trailing zeroes in $N!.
# 
#         Example 1
#         Input: $N = 10
#         Output: 2 as $N! = 3628800 has 2 trailing zeroes
# 
#         Example 2
#         Input: $N = 7
#         Output: 1 as $N! = 5040 has 1 trailing zero
# 
#         Example 3
#         Input: $N = 4
#         Output: 0 as $N! = 24 has 0 trailing zero
#
#         Notes:      
#         Heh. First misread this as just exhuberance on the part of Mohammad, then 
#         understood it to be n-factorial. Oops. 
#         
#         So we're going to need a factorial function. The variable is less than ten so a simple
#         recursion will serve. Then a regex, count the zeros and we're good. 
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use bigint;

## ## ## ## ## MAIN:

## we're going to ignore the directive and just print them all
## from 1 to $n 

my $n = shift @ARGV // 10000;

for my $n (1..$n) {
    my $fact    = fact($n);
    my ($zeros) = $fact =~ m/.*?(0*)$/;
    my $count   =  @{[split //, $zeros]} ;  ## baby cart operator

    my @plurals = $count == 1 ? ("is ", " ") : ("are", "s");
    
    say "there $plurals[0] $count trailing zero${plurals[1]} on " 
            . (sprintf "%2d! = ", $n) . $fact;
}


## ## ## ## ## SUBS:


sub fact {
## final form: memoized in case someone wants to put in large n
## makeshift reduction using a for loop
    state %memo;

    my $end = shift;
    if (exists $memo{ $end - 1 }) {
        $memo{ $end } = $memo{ $end - 1 } * $end;
        return $memo{ $end }
    }
    my $acc = 1;
    $acc *= $_ for (2..$end);
    $memo{ $end } = $acc;
    return $acc;
 }

## original recursive version
    # sub fact {
    #     my $n = shift;
    #     return 1 if $n == 1;
    #     return $n * fact ($n - 1);
    # }

## original accumulator version
    # sub fact {
    #     my $end = shift;
    #     my $acc = 1;
    #     $acc *= $_ for (2..$end);
    #     return $acc;
    # }

## List::Util::reduce version
    # use List::Util qw( reduce );  
    # sub fact { return reduce { $a * $b } (1..$_[0]) }
