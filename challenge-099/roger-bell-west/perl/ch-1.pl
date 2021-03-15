#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

is(pm('abcde','a*e'),1,'example 1');
is(pm('abcde','a*d'),0,'example 2');
is(pm('abcde','?b*d'),0,'example 3');
is(pm('abcde','a*c?e'),1,'example 4');

sub pm {
  my $text=shift;
  my $match=shift;
  (my $re=$match) =~ s/\?/./g;
  $re =~ s/\*/.*/g;
  $re='^'.$re.'$';
  if ($text =~ /$re/) {
    return 1;
  }
  return 0;
}
