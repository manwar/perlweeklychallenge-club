#! /usr/bin/perl

use strict;
use warnings;
use List::Util qw(max);

use Test::More tests => 2;

is(majority(1, 2, 2, 3, 2, 4, 2),
   2,
   "example 1");
is(majority(1, 3, 1, 2, 4, 5),
   -1,
   "example 2");

sub majority {
  my @list=@_;
  my %s;
  map {$s{$_}++} @list;
  my $m=max(values %s);
  if ($m > int((scalar @list)/2)) {
    my %q=map {$s{$_} => $_} keys %s;
    return $q{$m};
  } else {
    return -1;
  }
}
