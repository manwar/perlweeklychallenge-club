#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

die "Give me three strings\n" unless @ARGV == 3;

my ($bit1, $bit2, $result) = @ARGV;

my $done;

for (0 .. length $bit1) {
  my $foo = $bit1;
  substr($foo, $_, 0, $bit2);
  if ($foo eq $result) {
    $done = 1;
    last;
  }
}

say $done ? 1 : 0;
