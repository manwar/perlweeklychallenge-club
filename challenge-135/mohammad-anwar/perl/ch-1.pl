#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

=head1

Week 135:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-135

Task #1: Middle 3-digits

    You are given an integer.

    Write a script find out the middle 3-digits of the given integer, if possible otherwise throw sensible error.

=cut

is(middle_3_digits(1234567), 345, 'Example 1');
is(middle_3_digits(-123),    123, 'Example 2');

eval { middle_3_digits(1) };
like($@, qr/Too short/, 'Example 3');

eval { middle_3_digits(10) };
like($@, qr/Even number of digits/, 'Example 4');

done_testing;

sub middle_3_digits {
    my ($n) = @_;

    die "ERROR: Missing number."             unless defined $n;
    die "ERROR: Invalid number [$n]."        unless ($n =~ /\-?\d+/);

    my $num = abs($n);
    my $len = length($num);
    die "ERROR: Too short [$n]."             if ($len == 1);
    die "ERROR: Even number of digits [$n]." if ($len % 2 == 0);

    my $i = int($len / 2) - 1;
    return substr($num, $i, 3);
}
