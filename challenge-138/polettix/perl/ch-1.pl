#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Time::Local 'timegm';
use List::Util qw< min max >;

sub dow ($y, $m, $d) { (gmtime(timegm(1, 1, 1, $d, --$m, $y)))[6] }
sub workdays ($y) {
   my $bdow = dow($y, 1, 1);
   my $edow = dow($y, 12, 31);
   my $bdays = 8 - $bdow; # 1 - 7
   my $ydays = 365 + ($bdow == $edow ? 0 : 1) - $bdays - $edow;
   return max($bdays - 2, 0) + ($ydays / 7 * 5) + min($edow, 5);
}

say workdays(shift // 2021);
