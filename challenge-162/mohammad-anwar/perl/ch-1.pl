#!/usr/bin/perl

=head1

Week 162:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-162

Task #1: ISBN-13

    Write a script to generate the check digit of given ISBN-13 code.

=cut

use strict;
use warnings;

use Test::More;

is isbn_13_check_digit('978-0-306-40615-7'), 7, 'Example';

done_testing;

#
#
# METHOD

sub isbn_13_check_digit {
    my ($code) = @_;

    return unless defined $code;

    $code =~ s/(.*)\-\d/$1/;
    $code =~ s/\-//g;

    die "ERROR: Invalid ISBN-13 code.\n" unless $code =~ /^\d{12}$/;

    my @keys = (1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3);
    my @vals = split //,$code;

    my $sum = 0;
    while (my ($i, $v) = each @vals) {
        $sum += $v * $keys[$i];
    }

    return 10 - ($sum % 10);
}
