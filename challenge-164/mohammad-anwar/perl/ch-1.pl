#!/usr/bin/perl

=head1

Week 164:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-164

Task #1: Prime Palindrome

    Write a script to find all prime numbers less than 1000,
    which are also palindromes in base 10.

=cut

use strict;
use warnings;
use Test::More;

is_deeply(
    prime_palindrome(999),
    [  2,   3,   5,   7,  11,  13,  17,  31,  37,  71,  73,  79,
      97, 101, 107, 113, 131, 149, 151, 157, 167, 179, 181, 191,
     199, 311, 313, 337, 347, 353, 359, 373, 383, 389, 701, 709,
     727, 733, 739, 743, 751, 757, 761, 769, 787, 797, 907, 919,
     929, 937, 941, 953, 967, 971, 983, 991,
    ]
);

done_testing;

#
#
# METHODS

sub prime_palindrome {
    my ($n) = @_;

    my $pp = {};
    foreach my $i (1 .. $n) {
        next if exists $pp->{$i};

        my $_i = (reverse $i) + 0;
        next unless is_prime($i) and is_prime($_i);

        $pp->{$i}  = 1;;
        $pp->{$_i} = 1;
    }

    return [ sort { $a <=> $b } keys %$pp ];
}

sub is_prime {
    my ($n) = @_;

    return 0 if ($n == 1);

    do { return 0 unless ($n % $_) } for (2 .. sqrt $n);

    return 1;
}
