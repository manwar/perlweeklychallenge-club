#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);

use Test::More tests => 1;

is(psum(9),2,"example");

sub psum {
  my $n=shift;
  my %pr=map {$_ => 1} (2..$n);
  foreach my $m (2..$n) {
    foreach my $mi (2..$n) {
      delete $pr{$m*$mi};
    }
  }
  my @p=sort {$b <=> $a} keys %pr;
  my %pi=map {$p[$_] => $_} (0..$#p);
  my @c=([]);
  my @o;
  while (my $r=shift @c) {
    my $s=$n;
    if (@{$r}) {
      $s-=sum(map {$p[$_]} @{$r});
    }
    if ($s>0) {
      my %ru=map {$_ => 1} @{$r};
      foreach my $ci (grep {!exists $ru{$_}} map {$pi{$_}} grep {$_ <= $s} @p) {
        push @c,[@{$r},$ci];
      }
    } elsif ($s==0) {
      @o=map {$p[$_]} @{$r};
      last;
    }
  }
  return scalar @o;
}
