#! /usr/bin/perl

use strict;
use warnings;

# Write a script to display months from the year 1900 to 2019 where
# you find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

use Time::Local;
use POSIX qw(strftime);

foreach my $y (1900..2019) {
  foreach my $m (1,3,5,7,8,10,12) {
    my @d=gmtime(timegm(0,0,0,1,$m-1,$y));
    if ($d[6]==5) {
      print strftime('%B %Y',@d),"\n";
    }
  }
}
