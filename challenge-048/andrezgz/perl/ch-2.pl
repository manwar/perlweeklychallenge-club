#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/
# Task #2
#
# Palindrome Dates
# Write a script to print all Palindrome Dates between 2000 and 2999.
# The format of date is mmddyyyy.
# For example, the first one was on October 2, 2001 as it is represented as 10022001.

use strict;
use warnings;

my $y = 1999;

my @months = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;

while ( ++$y < 3000 ) {
    # year is inverted and divided to get month and day
    my ($m, $d) = scalar(reverse $y) =~ m/../g ;
    next unless is_valid_dom($y, $m, $d);
    print $months[$m-1] . ' ' . $d . ', ' . $y .$/;
}

sub is_valid_dom {
    my ($y, $m, $d) = @_;
    return if $d < 1 || $d > 31 || $m < 1 || $m > 12; # impossible days/months
    return if $d > 30  && grep {$m == $_} (4,6,9,11); # 30-day months
    return if $d > 29  && $m == 2;                    # 28-day February
    return if $d == 29 && $m == 2                     # 29-day February
              && ! ($y % 4 == 0 && ($y % 100 != 0 || $y % 400 == 0) ); # not a leap year
    return 1; # valid day for the month and year
}

__END__
./ch-2.pl
Oct 02, 2001
Jan 02, 2010
Nov 02, 2011
Feb 02, 2020
Dec 02, 2021
Mar 02, 2030
Apr 02, 2040
May 02, 2050
Jun 02, 2060
Jul 02, 2070
Aug 02, 2080
Sep 02, 2090
Oct 12, 2101
Jan 12, 2110
Nov 12, 2111
Feb 12, 2120
Dec 12, 2121
Mar 12, 2130
Apr 12, 2140
May 12, 2150
Jun 12, 2160
Jul 12, 2170
Aug 12, 2180
Sep 12, 2190
Oct 22, 2201
Jan 22, 2210
Nov 22, 2211
Feb 22, 2220
Dec 22, 2221
Mar 22, 2230
Apr 22, 2240
May 22, 2250
Jun 22, 2260
Jul 22, 2270
Aug 22, 2280
Sep 22, 2290
