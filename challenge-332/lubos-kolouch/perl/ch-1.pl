#!/usr/bin/env perl
use v5.38;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use Type::Params    qw(compile);
use Types::Standard qw(StrMatch);
use Test::More;

=pod

=head1 NAME

ch-1 - Binary Date converter

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

The script implements Task 1 (Binary Date) from The Weekly Challenge #332.
It exposes L</binary_date> that validates an ISO-8601 date string
and returns the corresponding binary representation for the year,
month, and day components joined with hyphens.

=cut

my $ISO_DATE   = StrMatch [qr/\A\d{4}-\d{2}-\d{2}\z/];
my $date_check = compile($ISO_DATE);

## no critic (Subroutines::ProhibitSubroutinePrototypes)
sub binary_date ($date) {
    ($date) = $date_check->($date);
    my ( $year, $month, $day ) = split /-/xms, $date;
    return join q{-}, map { sprintf '%b', $_ + 0 } ( $year, $month, $day );
}
## use critic

# Unit tests (Examples provided by the challenge)
is binary_date('2025-07-26'), '11111101001-111-11010',  'Example 1';
is binary_date('2000-02-02'), '11111010000-10-10',      'Example 2';
is binary_date('2024-12-31'), '11111101000-1100-11111', 'Example 3';

done_testing();
