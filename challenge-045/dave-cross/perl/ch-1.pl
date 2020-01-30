#!/usr/bin/perl

use strict;
use warnings;

@ARGV || die "Give me a message to encode\n";

my $msg = "@ARGV";

$msg =~ s/\s+//g;

my @lines = map { [ split // ] } $msg =~ /(.{1,8})/g;

for my $x (0 .. $#{$lines[0]}) {
  for my $y (0 .. $#lines) {
    print $lines[$y][$x] // '';
  }
  print ' ';
}

print "\n";
