#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(completingword('aBc 11c', ['accbbb', 'abc', 'abbc']), 'accbbb', 'example 1');
is(completingword('La1 abc', ['abcl', 'baacl', 'abaalc']), 'baacl', 'example 2');
is(completingword('JB 007', ['jj', 'bb', 'bjb']), 'bjb', 'example 3');

sub str2hash($a) {
  my %m;
  foreach my $c (split '', $a) {
    if ($c =~ /[[:alpha:]]/) {
      $m{lc($c)}++;
    }
  }
  return \%m;
}

sub completingword($a, $cw) {
  my $ah = str2hash($a);
  my @out;
  foreach my $t (@{$cw}) {
    my $valid = 1;
    my $th = str2hash($t);
    keys %{$ah};
    while (my ($k, $v) = each %{$ah}) {
      unless (exists $th->{$k}) {
        $valid = 0;
        last;
      }
      if ($th->{$k} < $v) {
        $valid = 0;
        last;
      }
    }
    if ($valid) {
      push @out, $t;
    }
  }
  unless (@out) {
    return "";
  }
  return (sort {length($::a) <=> length($::b)} @out)[0];
}
