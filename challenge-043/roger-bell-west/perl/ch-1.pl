#! /usr/bin/perl

use strict;
use warnings FATAL => 'all';

use List::MoreUtils qw(minmax);

my @names=qw(blue yellow black green red);
my @base=(8,7,0,5,9);
my @candidate=(1,2,3,4,6);
my $target=11;

my @index;
my @metanames;
foreach my $k (0..$#names-1) {
  push @metanames,$names[$k];
  push @metanames,$names[$k].'/'.$names[$k+1];
}
push @metanames,$names[-1];

foreach my $a (0..$#base*2) {
  $index[0]=$a;
  foreach my $b (0..$#base*2) {
    $index[1]=$b;
    foreach my $c (0..$#base*2) {
      $index[2]=$c;
      foreach my $d (0..$#base*2) {
        $index[3]=$d;
        foreach my $e (0..$#base*2) {
          $index[4]=$e;
          my @sums=@base;
          foreach my $i (0..$#candidate) {
            my $ix=int($index[$i]/2);
            $sums[$ix]+=$candidate[$i];
            if ($index[$i]%2==1) {
              $sums[$ix+1]+=$candidate[$i];
            }
          }
          my @l=minmax(@sums);
          if ($l[0]==$target && $l[1]==$target) {
            print join(', ',map {"$candidate[$_] in $metanames[$index[$_]]"} (0..$#candidate)),"\n";
          }
        }
      }
    }
  }
}
