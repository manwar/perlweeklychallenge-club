#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use List::Util qw(min);
use Test::More tests => 3;

is_deeply(commoncharacters(['java', 'javascript', 'julia']), ['j', 'a'], 'example 1');
is_deeply(commoncharacters(['bella', 'label', 'roller']), ['e', 'l', 'l'], 'example 2');
is_deeply(commoncharacters(['cool', 'lock', 'cook']), ['c', 'o'], 'example 3');

sub commoncharacters ($a) {
  my @ac;
  foreach my $w (@{$a}) {
    my %h;
    foreach my $c (split '', $w) {
      $h{$c}++;
    }
    push @ac, \%h;
  }
  my %vc = %{$ac[0]};
  foreach my $aa (@ac) {
    foreach my $c (keys %vc) {
      if (exists $aa->{$c}) {
        $vc{$c} = min($vc{$c}, $aa->{$c});
      } else {
        delete $vc{$c};
      }
    }
  }
  my @out;
  foreach my $c (split '', $a->[0]) {
    if (exists $vc{$c}) {
      push @out, $c;
      $vc{$c}--;
      if ($vc{$c} == 0) {
        delete $vc{$c};
      }
    }
  }
  return \@out;
}
