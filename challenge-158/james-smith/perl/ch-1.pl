#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(next_prime is_prime);
use Benchmark qw(cmpthese);

my $N = shift || 100;
my $I = 5e6/$N;
$I = 200 if $I<100;
say join ', ', count_primes_div();
say join ', ', count_primes_split();

cmpthese( 5e6/$N, {
  'div'   => sub { count_primes_div();   },
  'split' => sub { count_primes_split(); },
} );

sub count_primes_div {
  my @res;
  for( my $p = 2; my $s=0, (my $q=$p)<=$N; $p = next_prime $p ) {
    do { $s += $q%10 } while $q = int $q/10;
    push @res, $p if is_prime $s;
  }
  @res;
}


sub count_primes_split {
  my @res;
  for( my $p =2; my $s=0, $p <= $N ; $p = next_prime $p ) {
    $s+=$_ for split //,$p;
    push @res, $p if is_prime $s;
  }
  @res;
}

