#!/usr/bin/env perl
use v5.32;
use List::Util      qw/min sum/;
use List::MoreUtils qw/first_index/;
use Test::More;
use experimental    qw/signatures/;

is empty_array(3,4,2),                                                5;
is empty_array(1,2,3),                                                3;
is empty_array(16,17,8,15,13,11,19,5,12,6,20,2,4,10,3,14,1,7,9,18), 127;
done_testing;

sub empty_array(@a)
{
    my @r;

    while(@a)
    {
        my $i = first_index { $_ == min @a } @a;
        @a = (@a[$i+1..$#a], @a[0..$i-1]);
        push @r, $i+1;
    }

    sum @r
}
