#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(ga(qw(opt bat saw tab pot top was)),[[qw(bat tab)],[qw(opt pot top)],[qw(saw was)]],'example 1');
is_deeply(ga('x'),[['x']],'example 2');

sub ga {
  my @in=@_;
  my %g;
  foreach my $word (@in) {
    push @{$g{wh($word)}},$word;
  }
  my @out;
  foreach my $k (values %g) {
    push @out,[sort @{$k}];
  }
  @out=sort {$a->[0] cmp $b->[0]} @out;
  return \@out;
}

sub wh {
  my $w=shift;
  $w=lc($w);
  if ($w =~ /[^a-z]/) {
    return 0;
  }
  my $b=ord('a');
  my @p=(2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101);
  my $n=1;
  foreach my $c (split '',$w) {
    $n*=$p[ord($c)-$b];
  }
  return $n;
}
