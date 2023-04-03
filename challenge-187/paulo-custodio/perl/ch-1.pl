#!/usr/bin/perl

# Challenge 187
#
# Task 1: Days Together
# Submitted by: Mohammad S Anwar
#
# Two friends, Foo and Bar gone on holidays seperately to the same city. You are
# given their schedule i.e. start date and end date.
#
# To keep the task simple, the date is in the form DD-MM and all dates belong to
# the same calendar year i.e. between 01-01 and 31-12. Also the year is non-leap
# year and both dates are inclusive.
#
# Write a script to find out for the given schedule, how many days they spent
# together in the city, if at all.
# Example 1
#
# Input: Foo => SD: '12-01' ED: '20-01'
#        Bar => SD: '15-01' ED: '18-01'
#
# Output: 4 days
#
# Example 2
#
# Input: Foo => SD: '02-03' ED: '12-03'
#        Bar => SD: '13-03' ED: '14-03'
#
# Output: 0 day
#
# Example 3
#
# Input: Foo => SD: '02-03' ED: '12-03'
#        Bar => SD: '11-03' ED: '15-03'
#
# Output: 2 days
#
# Example 4
#
# Input: Foo => SD: '30-03' ED: '05-04'
#        Bar => SD: '28-03' ED: '02-04'
#
# Output: 4 days

use Modern::Perl;
use DateTime;
use DateTime::Format::Strptime;
use List::Util qw( min max );

sub days_together {
    my($as, $ae, $bs, $be) = @_;
    if ($bs > $ae || $as > $be) { return 0; }
    my $os = max($as, $bs);
    my $oe = min($ae, $be);
    my $days = $oe->delta_days($os)->delta_days()+1;
    return $days;
}

@ARGV==4 or die "usage: ch-1.pl dd-mm dd-mm dd-mm dd-mm\n";
my $strp = DateTime::Format::Strptime->new(pattern=>'%d-%m-%Y');
my @dt = map {$strp->parse_datetime("$_-2023")} @ARGV;  # random non-leap year
say days_together(@dt);
