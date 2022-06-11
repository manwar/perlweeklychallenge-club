#!/usr/bin/env perl

# Challenge 038
#
# TASK #1
# Date Finder
# Create a script to accept a 7 digits number, where the first number can only
# be 1 or 2. The second and third digits can be anything 0-9. The fourth and
# fifth digits corresponds to the month i.e. 01,02,03…,11,12. And the last
# 2 digits respresents the days in the month i.e. 01,02,03….29,30,31. Your
# script should validate if the given number is valid as per the rule and then
# convert into human readable format date.
#
# RULES
# If 1st digit is 1, then prepend 20 otherwise 19 to the 2nd and 3rd digits to
# make it 4-digits year.
#
# The 4th and 5th digits together should be a valid month.
#
# The 6th and 7th digits together should be a valid day for the above month.
#
# For example, the given number is 2230120, it should print 1923-01-20.

use Modern::Perl;
use DateTime;

my $input = shift || "";
$input =~ /^([12])(\d\d)([01]\d)([0-3]\d)$/ or die "malformed input\n";
my($year_msb, $year_lsb, $month, $day) = ($1, $2, $3, $4);
my $year = ($year_msb==1 ? 2000 : 1900)+$year_lsb;
$month>=1 && $month<=12 or die "malformed month\n";
my $dt = DateTime->new(year => $year, month => $month, day => 1);
$day>=1 && $day<=$dt->month_length or die "malformed day\n";
$dt = DateTime->new(year => $year, month => $month, day => $day);
say $dt->strftime("%Y-%m-%d");
