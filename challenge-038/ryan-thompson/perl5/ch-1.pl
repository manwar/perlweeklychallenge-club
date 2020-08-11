#!/usr/bin/env perl

# ch-1.pl - Weird dates
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

# This regex is the real star of the show
$ARGV[0] =~ /^
    (?<cent> [12]                    ) # Century, 1:1900, 2:2000
    (?<yy>   \d\d                    ) # Year (2-digit)
    (?<mm>   0[1-9] | 1[012]         ) # Month
    (?<dd>   0[1-9] | [12]\d | 3[01] ) # Day
$/x or die "usage: $0 Cyymmdd";

my $yyyy = $+{cent} + 18 . $+{yy};

# Without this check, we'd be done!
die "$yyyy-$+{mm} doesn't have $+{dd} days"
    unless days_in($yyyy, $+{mm}) >= $+{dd};

say "$yyyy-$+{mm}-$+{dd}";

# These helpers are usefully re-used from my solution from last week :-)

# Return the number of days in the given month (with year specified so
# we can check if it is a leap year)
sub days_in {
    my ($y, $m) = @_;
    my @days = (undef, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    $days[2]++ if leap_year($y);
    $days[$m];
}

# Return true if year is a leap year
sub leap_year {
    my $y = shift;
    return 1 unless $y % 400;
    return 0 unless $y % 100;
    return 1 unless $y % 4;
    return 0;
}
