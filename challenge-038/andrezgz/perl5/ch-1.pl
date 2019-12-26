#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-038/
# Task #1
# Date Finder
# Create a script to accept a 7 digits number,
# where the first number can only be 1 or 2.
# The second and third digits can be anything 0-9.
# The fourth and fifth digits corresponds to the month i.e. 01,02,03,...,11,12.
# And the last 2 digits respresents the days in the month i.e. 01,02,03,...,29,30,31.
# Your script should validate if the given number is valid as per the rule and
# then convert into human readable format date.
#
# RULES
# 1) If 1st digit is 1, then append 20 otherwise 19 to the 2nd and 3rd digits
#  to make it 4-digits year.
# 2) The 4th and 5th digits together should be a valid month.
# 3) The 6th and 7th digits together should be a valid day for the above month.
#
# For example, the given number is 2230120, it should print 1923-01-20.

use strict;
use warnings;

my $n = shift || die "USAGE $0 <7-digit-date>";

die 'invalid 7-digits date'.$/
    if $n !~ /^
                (?<y1>[12])                     # 1st: 1 or 2
                (?<y2>\d{2})                    # 2nd & 3rd: anything
                (?<m>0[1-9]|1[0-2])             # 4th & 5th: month
                (?<d>0[1-9]|[12][0-9]|3[01])    # 6th & 7th: day of the month
             $/x;

my $year = ( $+{y1} == 1 ? 20 : 19) . $+{y2};
my ( $month, $day) = ( $+{m}, $+{d} );

die "invalid day of month".$/ unless is_valid_dom($year, $month, $day);

print join '-', ($year, $month, $day);
exit 0;

sub is_valid_dom {
    my ($y, $m, $d) = @_;
    return if $d > 30  && grep {$m == $_} (4,6,9,11); # 30-day months
    return if $d > 29  && $m == 2;                    # 28-day February
    return if $d == 29 && $m == 2                     # 29-day February
              && ! ($y % 4 == 0 && ($y % 100 != 0 || $y % 400 == 0) ); # not a leap year
    return 1; # valid day for the month and year
}

__END__

./ch-1.pl 2230120
1923-01-20

$ ./ch-1.pl 1200229
2020-02-29
