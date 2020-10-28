#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;

sub task1 {
  my $S = shift;
  $S =~ s/^\w+\s+\b(.*)\b\s+\w+$/$1/;
  $S =~ tr/ \t//d;
  say length $S;
}

task1 "The Weekly Challenge";
task1 "The purpose of our lives is to be happy";

