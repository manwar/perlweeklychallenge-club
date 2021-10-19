#! /usr/bin/perl

use strict;
use warnings;

distinctterms(3,3);

distinctterms(3,5);

use List::Util qw(max sum);

sub distinctterms {
  my $m=shift;
  my $n=shift;
  my @r;
  push @r,['x',(1..$n)];
  my %terms;
  foreach my $mm (1..$m) {
    my @q=($mm);
    foreach my $nn (1..$n) {
      my $p=$mm*$nn;
      push @q,$p;
      $terms{$p}=1;
    }
    push @r,\@q;
  }
  my @cw=(0,0);
  foreach my $rr (@r) {
    foreach my $ci (0..$#{$rr}) {
      my $wi=$ci==0?0:1;
      $cw[$wi]=max($cw[$wi],length($rr->[$ci]));
    }
  }
  foreach my $ri (0..$#r) {
    my @k;
    if ($ri==0) {
      push @k,sprintf('%'.$cw[0].'s',$r[$ri][0]);
    } else {
      push @k,sprintf('%'.$cw[0].'d',$r[$ri][0]);
    }
    push @k,'|';
    foreach my $ci (1..$#{$r[$ri]}) {
      push @k,sprintf('%'.$cw[1].'d',$r[$ri][$ci]);
    }
    my $l=join(' ',@k);
    print "$l\n";
    if ($ri==0) {
      $l =~ s/[^|]/-/g;
      $l =~ s/\|/+/g;
      print "$l\n";
    }
  }
  print "\n";
  print "Distinct Terms: ".join(', ',sort {$a <=> $b} keys %terms)."\n";
  print "Count: ".(scalar keys %terms)."\n";
}
