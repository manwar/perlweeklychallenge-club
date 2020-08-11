#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

@ARGV or die "Please give me at least one string.\n";

for (@ARGV) {
  say for brace_expand($_);
}

sub brace_expand {
  my ($string) = @_;

  my $braced;
  unless (($braced) = $string =~ /\{(.+?)}/) {
    return $string;
  }

  return map { $string =~ s/\{.+?}/$_/r; } split /,/, $braced;
}
