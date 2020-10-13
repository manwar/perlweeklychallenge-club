#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;

is_deeply(factor(12),{1 => 1, 2 => 1, 3 => 1, 4 => 1, 6 => 1, 12 => 1},'twelve');
is_deeply(factor(18),{1 => 1, 2 => 1, 3 => 1, 6 => 1, 9 => 1, 18 => 1},'eighteen');
is_deeply(factor(23),{1 => 1, 23 => 1},'twenty-three');

is_deeply(commonfactor(12,18),[1,2,3,6],'twelve-eighteen');
is_deeply(commonfactor(18,23),[1],'twelve-twentythree');

sub factor {
  my $n=shift;
  my %o=map {$_ => 1} (1,$n);
  foreach my $i (2..int(sqrt($n))) {
    if ($n % $i == 0) {
      $o{$n/$i}=$o{$i}=1;
    }
  }
  return \%o;
}

sub commonfactor {
  my @f=map {factor($_)} @_;
  my $s=shift @f;
  while (@f) {
    my $q=shift @f;
    foreach my $f (keys %{$s}) {
      unless (exists $q->{$f}) {
        delete $s->{$f};
      }
    }
  }
  return [sort keys %{$s}];
}
