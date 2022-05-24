#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
$Data::Dumper::Sortkeys = 1;
my $re = 'abcdefoilst';
my $words = [];
while(<>) {
  chomp;
  next unless m{^[abcdefilostg]+$};
  my $t = $_;
  my $N = tr/oilstg/011579/;
  warn "$N\t$t\t$_\n" if $N == length $_;
  $words->[length $_]{$N}{$t}=$_;
}

print Dumper( $words );

