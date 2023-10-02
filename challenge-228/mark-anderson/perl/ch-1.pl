#!/usr/bin/env perl
use v5.32;
use List::Util   qw/sum0/;
use Test::More;
use experimental qw/signatures/;

is unique_sum(2,1,3,2),  4;
is unique_sum(1,1,1,1),  0;
is unique_sum(2,1,3,4), 10;
done_testing;

sub unique_sum(@a)
{
    my %bag;
    $bag{$_}++ for @a;
    sum0 grep { $bag{$_} == 1 } keys %bag
}
