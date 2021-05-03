#!/usr/bin/perl
# The Weekly Challenge 111
# Task 1 Search  Matrix
use strict;
use warnings;

my $matrix=[[  1,  2,  3,  5,  7 ],
            [  9, 11, 15, 19, 20 ],
            [ 23, 24, 25, 29, 31 ],
            [ 32, 33, 39, 40, 42 ],
            [ 45, 47, 48, 49, 50 ]];

my $target = $ARGV[0];

my @list25;
push @list25, $_->@* foreach (@{$matrix});

my @my_seq = (12,6,3,2,1,1);
my $h = shift @my_seq;

for (my $i=0; $i < scalar @my_seq ;$i++) {
    if ($target > $list25[$h]) {
        $h += $my_seq[$i];
    } elsif ($target < $list25[$h]) {
        $h -= $my_seq[$i];
    } elsif ($target == $list25[$h]) {
        print "1\n";
        exit;
    }
}

print "0\n";


