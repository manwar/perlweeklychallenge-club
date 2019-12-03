#! /usr/bin/perl

use strict;
use warnings;

use Time::Local;
use POSIX qw(strftime);

my $y=2019;

my $s=timegm(0,0,12,1,0,$y);
my $e=timegm(0,0,12,1,0,$y+1);

my @o;
my @m;

for (my $t=$s;$t<$e;$t+=86400) {
  my @d=gmtime($t);
  if ($d[6]>0 && $d[6]<6) {
    $o[$d[4]]++;
    unless (defined $m[$d[4]]) {
      $m[$d[4]]=strftime('%b',@d);
    }
  }
}

foreach my $i (0..$#o) {
  print "$m[$i]: $o[$i] days\n";
}
