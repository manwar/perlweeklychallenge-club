#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;

sub substrings :prototype($) {
  my $s = shift;
  my $len = length $s;
  my %subs;
  for my $start (0 .. $len - 1) {
    for my $slen (1 .. $len - $start) {
      $subs{substr $s, $start, $slen} = 1;
    }
  }
  return keys %subs;
}

sub task1 :prototype($$) {
  my ($A, $B) = @_;
  my (@common, %subs);
  for (substrings($A), substrings($B)) {
    $subs{$_} += 1;
  }
  while (my ($substr, $count) = each %subs) {
    next if $count != 2;
    push @common, $substr if ($A =~ /^(?:$substr)+$/ && $B =~ /^(?:$substr)+$/);
  }
  say join(" ", sort @common);
}

task1 "abcdabcd", "abcdabcdabcdabcd";
task1 "aaa", "aa";
