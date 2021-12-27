#!/usr/bin/env perl

# Challenge 132
#
# TASK #1 > Mirror Dates
# Submitted by: Mark Anderson
# You are given a date (yyyy/mm/dd).
#
# Assuming, the given date is your date of birth. Write a script to find the
# mirror dates of the given date.
#
# Dave Cross has built cool site that does something similar.
#
# Assuming today is 2021/09/22.
# Example 1:
# Input: 2021/09/18
# Output: 2021/09/14, 2021/09/26
#
# On the date you were born, someone who was your current age, would have
# been born on 2021/09/14.
# Someone born today will be your current age on 2021/09/26.
# Example 2:
# Input: 1975/10/10
# Output: 1929/10/27, 2067/09/05
#
# On the date you were born, someone who was your current age, would have
# been born on 1929/10/27.
# Someone born today will be your current age on 2067/09/05.
# Example 3:
# Input: 1967/02/14
# Output: 1912/07/08, 2076/04/30
#
# On the date you were born, someone who was your current age, would have
# been born on 1912/07/08.
# Someone born today will be your current age on 2076/04/30.

use Modern::Perl;
use DateTime;

@ARGV==2 or die "Usage: ch-1.pl birth-date today\n";
my($birth_text, $today_text) = @ARGV;
my $birth = parse_date($birth_text);
my $today = parse_date($today_text);

my $days = $birth->delta_days($today);
my $mirror1 = $birth->clone->subtract($days);
my $mirror2 = $today->clone->add($days);

say $mirror1->ymd('/'), ", ", $mirror2->ymd('/');

sub parse_date {
    my($str) = @_;
    $str =~ m{^(\d{4})/(\d{2})/(\d{2})$}
        or die "date format should be yyyy/mm/dd\n";
    my($yy,$mm,$dd) = ($1,$2,$3);
    my $date = DateTime->new(
        year       => $yy,
        month      => $mm,
        day        => $dd,
    );
    return $date;
}
