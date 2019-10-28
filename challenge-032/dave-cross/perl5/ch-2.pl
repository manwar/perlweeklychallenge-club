#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use List::Util 'max';
use Term::ReadKey;

my $input = {
  apple  => 3,
  cherry => 2,
  banana => 1,
};

say "Sort by keys:";
say text_bar($input);
say "\nSort by values:";
say text_bar($input, 'v');

sub text_bar {
  my ($data) = @_;

  my $sort_by_keys = 1;
  if (lc ($_[1] // '') eq 'v') {
    $sort_by_keys = 0;
  }

  my ($width) = GetTerminalSize;
  say $width;

  my $keylen = max map { length } keys %$data;
  my $maxval = max values %$data;

  my $step   = int($width - $keylen - 3) / $maxval;

  if ($sort_by_keys) {
    for (sort keys %$data) {
      printf "%${keylen}s : %s\n", $_, '#' x ($data->{$_} * $step);
    }
  } else{
    for (sort { $data->{$b} <=> $data->{$a} } keys %$data) {
      printf "%${keylen}s : %s\n", $_, '#' x ($data->{$_} * $step);
    }
  }
}
