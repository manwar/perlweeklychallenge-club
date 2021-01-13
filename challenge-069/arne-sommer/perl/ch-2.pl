#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings "experimental::signatures";

my $limit = $ARGV[0] // 30;

sub switch ($string)
{
  return join("", map { $_ eq "1" ? 0 : 1 } split("", $string));
}

my $prev = "";

for my $counter (0 .. $limit)
{
  say "S" . $counter++ . " = \"$prev\"";
  $prev = $prev . "0" . switch(reverse($prev));
}
