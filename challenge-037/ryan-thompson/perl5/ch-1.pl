#!/usr/bin/env perl

# ch-1.pl - Count weekdays (per month) in specified year (or current year)
#           Done here with only core modules.
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use Time::localtime;    # Named interface to localtime().

my @Mon = qw< Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec >;

my ( $timestamp, $now ) = ( time, localtime );

my $year = shift // $now->year + 1900; # Year defaults to current year

# Get $timestamp to within correct $year. Almost always loops once.
# Loops twice in edge case with leap years, which is still easier than
# calculating it.
do {
    $timestamp += ( $year - ( $now->year + 1900 ) ) * 86400 * 365;
    $now = localtime $timestamp;
} while ( $now->year + 1900 != $year );

# Then we just subtract the yday to get our timestamp to yyyy-01-01
$timestamp -= $now->yday * 86400;
$now = localtime $timestamp;

# Now we simply iterate through the year and count up the weekdays.
my %weekdays;
while ( $now->year + 1900 == $year ) {
    $weekdays{ $Mon[ $now->mon ] }++ if $now->wday > 0 and $now->wday < 6;
    $timestamp += 86400;
    $now = localtime $timestamp;
}

say "$_: $weekdays{$_} days" for @Mon;
