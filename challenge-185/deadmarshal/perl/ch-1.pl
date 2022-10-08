#!/usr/bin/env perl
use strict;
use warnings;

sub mac_address{
  my ($str) = @_;
  my @arr = grep {/[^.]/} split '', $str;
  my @ret;
  push @ret, [splice @arr, 0, 2] while @arr;
  return join ':', map {join '', @$_} @ret;
}

print mac_address("1ac2.34f0.b1c2"), "\n";
print mac_address("abc1.20f1.345a"), "\n";
