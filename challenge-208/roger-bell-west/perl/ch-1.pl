#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(minindexsum(['Perl', 'Raku', 'Love'], ['Raku', 'Perl', 'Hate']), ['Perl', 'Raku'], 'example 1');
is_deeply(minindexsum(['A', 'B', 'C'], ['D', 'E', 'F']), [], 'example 2');
is_deeply(minindexsum(['A', 'B', 'C'], ['C', 'A', 'B']), ['A'], 'example 3');

sub v2hm($a) {
  my %h;
  foreach my $i (0..$#{$a}) {
    unless (exists $h{$a->[$i]}) {
      $h{$a->[$i]} = $i;
    }
  }
  return \%h;
}

sub minindexsum($a, $b) {
  my $ah = v2hm($a);
  my $bh = v2hm($b);
  my @out;
  my $mi = scalar @{$a} + scalar @{$b};
  foreach my $w (@{$a}) {
    if (exists $bh->{$w}) {
      my $mv = $ah->{$w} + $bh->{$w};
      if ($mv < $mi) {
        @out = ();
        $mi = $mv;
      }
      if ($mv == $mi) {
        push @out, $w;
      }
    }
  }
  return \@out;
}
