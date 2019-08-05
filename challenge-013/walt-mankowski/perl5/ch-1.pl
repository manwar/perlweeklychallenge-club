#!/usr/bin/env perl

# Perl Weekly Challenge 013-1
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-013/
#
# Write a script to print the date of last Friday of every month of a
# given year. For example, if the given year is 2019 then it should
# print the following:
#
# 2019/01/25
# 2019/02/22
# 2019/03/29
# 2019/04/26
# 2019/05/31
# 2019/06/28
# 2019/07/26
# 2019/08/30
# 2019/09/27
# 2019/10/25
# 2019/11/29
# 2019/12/27

use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);
use Time::Local;

my $year = shift @ARGV || current_year();
my $leap = is_leap($year);
my @dim = ([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
           [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
          );

for my $mon (0..11) {
    # get dow for first of the month
    my $dom = 1;
    my $time = timelocal(undef, undef, undef, $dom, $mon, $year);
    my $dow = (localtime($time))[6];

    # advance $dom to Friday
    $dom += (5 - $dow) % 7;

    # advance $dom to last Friday
    $dom += 7 until $dim[$leap]->[$mon] - $dom < 7;

    # print it
    printf "%d/%02d/%d\n", $year, $mon+1, $dom;
}

sub current_year() {
    return (localtime)[5] + 1900;
}

sub is_leap($year) {
    return $year % 400 == 0 || ($year % 4 == 0 && $year % 100 != 0);
}

