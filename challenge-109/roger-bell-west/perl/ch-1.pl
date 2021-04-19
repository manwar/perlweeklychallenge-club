#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);

use Test::More tests => 1;

is_deeply(chowla(20),[0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21],'example 1');

sub chowla {
  my $count=shift;
  my @a;
  foreach my $n (1..$count) {
    push @a,sum(0,grep {$n % $_ == 0} (2..int($n/2)));
  }
  return \@a;
}

