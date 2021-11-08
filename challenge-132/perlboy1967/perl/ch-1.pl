#!/bin/perl

# Perl Weekly Challenge - 132
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-132/#TASK1
#
# Task 1 - Mirror Dates
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Date::Calc qw(Delta_Days Add_Delta_Days);
use POSIX qw(strftime);

use Test::More;
use Test::Deep;

# Prototype(s)
sub mirrorDates($$);


my $date = '2021/09/22';

is_deeply([mirrorDates('2021/09/18', $date)],['2021/09/14','2021/09/26']);
is_deeply([mirrorDates('1975/10/10', $date)],['1929/10/27','2067/09/05']);
is_deeply([mirrorDates('1967/02/14', $date)],['1912/07/08','2076/04/30']);

done_testing;


foreach $date (@ARGV) {
  printf "Mirror date of '%s' is '%s' and '%s'\n", 
         $date, mirrorDates($date, strftime('%Y/%m/%d', gmtime));
}


sub mirrorDates($$) {
  my @d;

  foreach (@_) {
    push(@d,[$1,$2,$3]) if (m#^(\d+)\D(\d+)\D(\d+)$#);
  }

  my $interval = Delta_Days(@{$d[0]}, @{$d[1]});

  my @r = (
    [Add_Delta_Days(@{$d[0]}, -$interval)],
    [Add_Delta_Days(@{$d[1]}, $interval)]
  );

  return sprintf('%d/%02d/%02d', @{$r[0]}),
         sprintf('%d/%02d/%02d', @{$r[1]});
}
