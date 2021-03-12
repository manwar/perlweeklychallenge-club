#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is(wp(1606134123,1614591276,'t2.csv'),'00:10:24 Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)','example 1');

use Text::CSV_XS qw(csv);
use List::Util qw(sum);

sub wp {
  my $ts=shift;
  my $tn=shift;
  my $csvfile=shift;
  my $td=($tn-$ts)*1000;
  my $aoa=csv(in => $csvfile);
  my $tp=sum(map {$_->[0]} @{$aoa});
  $td %= $tp;
  foreach my $t (@{$aoa}) {
    if ($td < $t->[0]) {
      $td=int($td/1000);
      my $h=int($td/3600);
      my $m=int($td/60) % 60;
      my $s=$td % 60;
      return sprintf('%02d:%02d:%02d %s',$h,$m,$s,$t->[1]);
    } else {
      $td-=$t->[0];
    }
  }
}
