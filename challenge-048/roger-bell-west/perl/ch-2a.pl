#! /usr/bin/perl

use strict;
use warnings;

foreach my $y (2000..2999) {
  foreach my $m (1..12) {
    foreach my $d (1..31) {
      if ($d==31 && ($m==4 || $m==6 || $m==9 || $m==11)) {
        next;
      } elsif ($m==2 && $d==30) {
        next;
      } elsif ($m==2 && $d==29 && ($y % 4 != 0 || ($y % 100 == 0 && $y % 400 != 0))) {
        next;
      }
      my $u=sprintf('%02d%02d%04d',$m,$d,$y);
      if ($u eq scalar reverse $u) {
        print "$u\n";
      }
    }
  }
}
