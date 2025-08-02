#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(nicestring('YaaAho'), 'aaA', 'example 1');
is(nicestring('Cc'), 'Cc', 'example 2');
is(nicestring('A'), '', 'example 3');

sub nicestring($a) {
  my @c = split '', $a;
  my $l = scalar @c;
  for (my $sl = $l; $sl >= 2; $sl--) {
    foreach my $start (0 .. $l - $sl) {
      my @s = @c[$start .. $start + $sl - 1];
      my %lower;
      my %upper;
      foreach my $ch (@s) {
        if ($ch =~ /[a-z]/) {
          $lower{$ch} = 1;
        } elsif ($ch =~ /[A-Z]/) {
          $upper{lc($ch)} = 1;
        }
      }
      my $valid = 1;
      foreach my $k (keys %lower) {
        if (exists $upper{$k}) {
          delete $upper{$k};
        } else {
          $valid = 0;
          last;
        }
      }
      if (scalar keys %upper != 0) {
        $valid = 0;
      }
      if ($valid) {
        return join('', @s);
      }
    }
  }
  "";
}
