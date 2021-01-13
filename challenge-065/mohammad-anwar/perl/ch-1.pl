#!/usr/bin/perl

#
# Perl Weekly Challenge - 065
#
# Task #1: Digits Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-065/
#

use strict;
use warnings;

use List::Util qw(sum);

my $N = $ARGV[0] || 2;
my $S = $ARGV[1] || 4;

print sprintf("%s\n", join(", ", find_numbers($N, $S)));

sub find_numbers {
    my ($digits, $sum) = @_;

    die "ERROR: Missing digits.\n" unless defined $digits;
    die "ERROR: Missing sum.\n"    unless defined $sum;

    die "ERROR: Invalid digits [$digits].\n" unless ($digits =~ /^[0-9]+$/);
    die "ERROR: Invalid sum [$sum].\n"       unless ($sum    =~ /^[0-9]+$/);

    my $start = sprintf("%d", '1' . '0' x ($digits-1));
    my $end   = sprintf("%d", '9' x $digits);
    --$start;

    my @numbers;
    while (++$start <= $end) {

        my @digits = split //, $start;
        next if (grep { $_ > $sum } @digits);

        my $SUM = sum @digits;
        next if ($SUM != $sum);

        push @numbers, $start;
    }

    return @numbers;
}
