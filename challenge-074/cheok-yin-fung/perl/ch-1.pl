#!/usr/bin/perl
# ref:
# https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_majority_vote_algorithm
# Perl Weekly Challenge #074 Task 1 Majority Element
# task statement: 
# Write a script to find the majority element. 
# If none found then print -1.
# Usage: ch-1.pl [ARRAY]
use strict;
use warnings;
#use Test::More tests => 3;


sub verify {
    my @array = @{$_[0]};
    my $m = $_[1];
    my $c = 0;
    for (@array) {
        $c++ if $m==$_;
    }
    return ($c > (scalar @array)/2.0 ? 1 : undef);
}

sub bm_majority_vote_alg {
    my @array = @{$_[0]};
    my $i = 0;
    my $m;
    for (@array) {
        if ($i == 0) {
            $m = $_;
            $i++
        }
        else {
            $m == $_ ? $i++ : $i--;
        }
    }
    

    return ( verify(\@array, $m) ? $m : -1 );
}


print bm_majority_vote_alg(\@ARGV);

=pod
is_deeply(  bm_majority_vote_alg( [1, 2, 2, 3, 2, 4, 2] ) , "2", "example1 provided");
is_deeply(  bm_majority_vote_alg( [1, 3, 1, 2, 4, 5] ) , "-1", "example2 provided");
is_deeply(  bm_majority_vote_alg( [2, 2, 2, 3, 1, 3, 4] ) , "-1", "array: 2223134");
=cut
