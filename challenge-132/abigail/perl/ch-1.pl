#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# First question we need to ask for any date related exercise is
# "What calendar are we using?". If you answer "Gregorian", then
# the next question is, "Where are we using the calendar?", as 
# different countries switched to the Gregorian calendar at different
# times. The first countries switched in the 16th century, but others
# switched as late as the 20th century.
#

#
# We will opt to use the proleptic Gregorian calendar, which is basically
# the Gregorian calendar extended backwards to the time no Gregorian 
# calender existed.
#
# Since the format is given as YYYY/MM/DD, we will assume non-negative years.
#

#
# We could pull one of the gazillion date modules from CPAN and let it
# do the calculations. But we'll do the calculations ourselves. We'll
# take the date, calculate its Julian Day number (rounded down, as we don't
# care about hours and minutes), compare it to the Julian Day number of today,
# and then calculate the Julian Day numbers of the target dates, after
# which we convert them back to dates.
#

#
# Conversion functions from Wikipedia
#

sub g2j ($Y, $M, $D) {
    use integer;
    (1461 * ($Y + 4800 + ($M - 14) / 12)) / 4  +
    (367 * ($M - 2 - 12 * (($M - 14) / 12))) / 12 -
    (3 * (($Y + 4900 + ($M - 14) / 12) / 100)) / 4 + $D - 32075
}

sub j2g ($J) {
    use integer;
    my $e = 4 * ($J + 1401 + (((4 * $J + 274277) / 146097) * 3) / 4 - 38) + 3;
    my $D =  ((5 * (($e % 1461) / 4) + 2) % 153) / 5 + 1;
    my $M = (((5 * (($e % 1461) / 4) + 2) / 153 + 2) % 12) + 1;
    my $Y = ($e / 1461) - 4716 + (12 + 2 - $M) / 12;
    ($Y, $M, $D)
}


my @TODAY = (2021, 9, 22);   # Use a fixed today, so we have expected
                             # test results.

my $julian_today = g2j @TODAY;

while (<>) {
    my ($Y, $M, $D) = /[0-9]+/g;
    my $julian_then = g2j $Y, $M, $D;
    printf "%04d/%02d/%02d, %04d/%02d/%02d\n",
             j2g (2 * $julian_then  - $julian_today),
             j2g (2 * $julian_today - $julian_then);
}


__END__
