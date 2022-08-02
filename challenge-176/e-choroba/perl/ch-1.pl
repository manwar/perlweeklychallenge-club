#! /usr/bin/perl
use warnings;
use strict;

sub permuted_multiples {
    my $candidate = 1;

  CANDIDATE:
    while (1) {
        my %count_digit;
        ++$count_digit{$_} for split //, $candidate;
        for my $times (2 .. 6) {
            my %digits;
            ++$digits{$_} for split //, $times * $candidate;
            for my $digit (keys %digits) {
                next CANDIDATE
                    unless $digits{$digit} == ($count_digit{$digit} // 0);

                delete $digits{$digit};
            }
            next CANDIDATE
                if keys %digits;
        }
        return $candidate
    } continue {
        ++$candidate;
    }
}

use Test::More tests => 1;
is permuted_multiples(), 142857, 'Expected result';
