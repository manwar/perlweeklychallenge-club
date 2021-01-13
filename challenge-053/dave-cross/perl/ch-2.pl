#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $count = get_arg();

my %strings = (
  a => [qw[e i]],
  e => [qw[i]],
  i => [qw[a e o u]],
  o => [qw[a u]],
  u => [qw[o e]],
);

my @words = map { [ $_ ] } keys %strings;

@words = add_letter(@words) for 2 .. $count;

say @$_ for sort { "@$a" cmp "@$b" } @words;

sub get_arg {
  die "Must give an integer between 1 and 5\n"
    if !@ARGV or $ARGV[0] =~ /\D/ or ! $ARGV[0] or $ARGV[0] > 5;

  return $ARGV[0];
}

sub add_letter {
  my @input = @_;
  my @output;

  for my $in (@input) {
    push @output, map { [ @$in, $_ ]} @{$strings{$in->[-1]}};
  }

  return @output;
}
