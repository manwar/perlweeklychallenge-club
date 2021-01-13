#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(max);
use Data::Dumper;

my $n=$ARGV[0] || 4;

my @a;

my $o;
my $m=0;

my @ap=([1,2],[0,2],[0,1]);

do {
  my $r=[];
  my @u;
  my $cm=-1;
  if (@a) {
    $r=shift @a;
    foreach my $c (@{$r}) {
      foreach my $api (0..2) {
        $u[$api]{$c->[$ap[$api][0]]}{$c->[$ap[$api][1]]}=1;
        $cm=max($cm,compose(@{$c}));
      }
    }
  }
  my $d=0;
  foreach my $x (0..$n-1) {
    foreach my $y (0..$n-1) {
      if (exists $u[2]{$x}{$y}) {
        next;
      }
      foreach my $z (0..$n-1) {
        if (exists $u[1]{$x}{$z} || exists $u[0]{$y}{$z}) {
          next;
        }
        if (compose($x,$y,$z)<=$cm) {
          next;
        }
        my @k=(@{$r},[$x,$y,$z]);
      OUTER:
        foreach my $a (0..$#k-1) {
          foreach my $b ($a+1..$#k) {
            foreach my $api (0..2) {
              my @ax=grep {$_ != $api} (0..2);
              my $l=abs($k[$a][$ax[0]]-$k[$b][$ax[0]]);
              if ($l ==
                    abs($k[$a][$ax[1]]-$k[$b][$ax[1]]) &&
                    ($k[$a][$api] == $k[$b][$api])) {
                @k=();
                last OUTER;
              }
            }
          }
        }
        if (@k) {
          $d=1;
          push @a,\@k;
        }
      }
    }
  }
  unless ($d) {
    my $n=scalar @{$r};
    if ($n>$m) {
      $m=$n;
      $o=$r;
    }
  }
} while (@a);

if (defined $o) {
  my @grid;
  foreach my $x (0..$n-1) {
    my $a;
    foreach my $y (0..$n-1) {
      my $b;
      foreach my $z (0..$n-1) {
        push @{$b},0;
      }
      push @{$a},$b;
    }
    push @grid,$a;
  }

  foreach my $q (@{$o}) {
    $grid[$q->[0]][$q->[1]][$q->[2]]=1;
  }

  print Dumper(\@grid);
}

sub compose {
  my ($x,$y,$z)=@_;
  return $x*$n*$n+$y*$n+$z;
}
