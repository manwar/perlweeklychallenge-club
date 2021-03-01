#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is_deeply(rn(2),[65],'example 1');
is_deeply(rn(6),[621770],'example 2');
is_deeply(rn(9),[281089082],'example 3');

sub rn {
  my $d=shift;
  my @out;
  my $mxm=10**($d-2)-1;
  foreach my $a (2,4,6,8) {
    foreach my $q (0,2,3,5,7,8) {
      if ($a==2 && $q!=2) {
        next;
      }
      if ($a==4 && $q!=0) {
        next;
      }
      if ($a==6 && $q!=0 && $q!=5) {
        next;
      }
      if ($a==8 && $q!=2 && $q!=3 && $q!=7 && $q!=8) {
        next;
      }
      if ($d==2) {
        my $t="$a$q";
        if (is_rare($t)) {
          push @out,$t;
        }
      } else {
        foreach my $middledigits (map {sprintf('%0'.($d-2).'d',$_)} 0..$mxm) {
          my $b=substr($middledigits,0,1);
          my $p=substr($middledigits,-1,1);
          if ($a==2 && $b!=$p) {
            next;
          }
          if ($a==4 && abs($b-$p)%2 != 0) {
            next;
          }
          if ($a==6 && abs($b-$p)%2 != 1) {
            next;
          }
          if ($a==8) {
            if ($q==2 && $b+$p != 9) {
              next;
            } elsif ($q==3 && $b-$p != 7 && $p-$b != 3) {
              next;
            } elsif ($q==7 && $b+$p != 1 && $b+$p != 11) {
              next;
            } elsif ($q==8 && $b!=$p) {
              next;
            }
          }
          my $t="$a$middledigits$q";
          if (is_rare($t)) {
            push @out,$t;
          }
        }
      }
    }
  }
  return \@out;
}

sub is_rare {
  my $t=shift;
  my $d=join('',reverse(split '',$t));
  if ($d >= $t) {
    return 0;
  }
  foreach my $c ($t+$d,$t-$d) {
    if ($c =~ /[2378]$/) {
      return 0;
    }
    my $s=int(sqrt($c));
    unless ($s*$s==$c) {
      return 0;
    }
  }
  return 1;
}
