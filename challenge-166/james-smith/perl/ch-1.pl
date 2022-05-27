#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
$Data::Dumper::Sortkeys = 1;

my $words = [];

my $ACTION  = 'any';
#  $ACTION  = 'numbers';
#  $ACTION  = '2numbers';
   $ACTION  = 'letters';

while(<>) {
  chomp;
  next unless m{^[abcdefoilstg]+$};
  my $t = $_;
  my $N = tr/oilstg/011579/;
  next if $ACTION eq 'numbers'  && $N < length $_;
  next if $ACTION eq 'letters'  && $N > 0;
  next if $ACTION eq '2numbers' && $N > 15;
  warn "$N\t$t\t$_\n" if $N == length $_;
  $words->[length $_]{$N}{$t}="$_ (".hex($_).")";
}

print Dumper( $words );

