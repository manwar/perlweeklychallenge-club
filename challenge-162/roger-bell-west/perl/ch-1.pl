#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

is(generate("978-0-306-40615-"),7,'example 1');
is(generate("978-0-306-40615-7"),7,'example 2');
is(validate("978-0-306-40615-7"),1,'example 3');
is(validate("978-0-306-46015-7"),0,'example 4');

sub generate {
  my $in = shift;
  $in =~ s/[^0-9]+//g;
  if (length($in) < 12) {
    return 99;
  }
  my $s=0;
  my $m=1;
  foreach my $i (0..11) {
    $s += substr($in,$i,1) * $m;
    $m = 4 - $m;
  }
  return (10-($s % 10)) % 10;
}

sub validate {
  my $in = shift;
  $in =~ s/[^0-9]+//g;
  if (length($in) != 13) {
    return 0;
  }
  return (generate($in)+0 == substr($in,12,1)+0)?1:0;
}
