#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use v5.20;

use feature 'signatures';
no warnings 'experimental::signatures';

my @list1 = ('ab1234', 'cd5678', 'ef1342');
my @list2 = ('pq1122', 'rs3334');

say sequence_number(@list1);
say sequence_number(@list2);

sub sequence_number (@list)
{
  my @return;

  for my $string (@list)
  {
    state $count = 0;

    push(@return, sprintf('%02d', $count) . substr($string, 2, 4));
    $count++;
  }

  return "(" . join(", ", map { "'$_'"} @return) . ")";
}
