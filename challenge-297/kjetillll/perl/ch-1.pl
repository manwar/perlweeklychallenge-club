#https://theweeklychallenge.org/blog/perl-weekly-challenge-297/
use strict; use warnings; use List::Util 'max'; use Test::More tests => 14; use Time::HiRes 'time';

sub max_len_eq_count_SLOW {
    max                                          # return max of those lengths
    map length,                                  # care only about the lengths for those subarrays/substrs
    grep y/0/0/ == y/1/1/,                       # filter out subarrays with different count for 0's and 1's
    map { join '', @_[ $$_{from} .. $$_{to} ] }  # stringify subarrays
    map { { from => int($_/@_), to => $_%@_ } }  # all from's and to's in subarrays (x,y) in "grid"
    0   ..   @_ * @_  -  1                       # use N x N "grid" for all indices
}

sub max_len_eq_count_FAST {
    my($sum, $i, %sfsa) = (0, 0, 0 => -1); #sfsa = sum first seen at (initialized)
    max map { $sfsa{ $sum += $_ * 2 -1 } //= $i; $i++ - $sfsa{ $sum } } @_
}

for my $test (
    [1, 0              => 2],
    [0, 1, 0           => 2],
    [0, 0, 0, 0, 0     => 0],
    [0, 1, 0, 0, 1, 0  => 4],
    [0, 1, 0, 1, 0, 0, 1, 0  => 6],
    [0, 1, 0, 1, 0, 0, 1, 0, 1, 1  => 10],
    [(map sprintf("%b",$_*771)=~/./g,1..28) => 238]
){
    my $expected = pop @$test;

    my $t = time;
    my $got = max_len_eq_count_SLOW( @$test );
    my $microsec = int((time-$t)*1e6);
    is $got, $expected, " input len: ".@$test."   SLOW: $microsec microsec            got: $got   exp: $expected   input: @$test";

    $t = time;
    $got = max_len_eq_count_FAST( @$test );
    $microsec = int((time-$t)*1e6);
    is $got, $expected, " input len: ".@$test."   FAST: $microsec microsec            got: $got   exp: $expected   input: @$test";
}
