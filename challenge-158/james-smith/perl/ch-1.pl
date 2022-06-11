#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(next_prime is_prime);
use Benchmark qw(cmpthese);
use List::Util qw(sum0);

my $N = shift || 100;
my $I = 1e7/$N;
$I = 100 if $I<100;
say join ', ', additive_primes_div();
say join ', ', additive_primes_div_expanded();
say join ', ', additive_primes_split();
say join ', ', additive_primes_split_sum0();

cmpthese( $I, {
  'split'   => sub { additive_primes_split();        },
  'sum0'    => sub { additive_primes_split_sum0();   },
  'div'     => sub { additive_primes_div();          },
  'div_exp' => sub { additive_primes_div_expanded(); },
} );

sub additive_primes_div_expanded {
  my @res;
  for(
    my $p = 2                                             ;
    my $s = 0,                        ( my $q = $p ) <= $N;
    (is_prime $s) && (push @res, $p), $p = next_prime $p
  ) {
    do { $s += $q % 10 } while $q = int $q / 10;
  }
  @res;
}

sub additive_primes_div {
  my @res;
  for( my $p = 2; my $s = 0, ( my $q = $p ) <= $N; (is_prime $s) && (push @res, $p), $p = next_prime $p ) {
    do { $s += $q % 10 } while $q = int $q / 10;
  }
  @res;
}


sub additive_primes_split {
  my @res;
  for( my $p = 2; my $s = 0, $p <= $N ; $p = next_prime $p ) {
    $s+=$_ for split //, $p;
    push @res, $p if is_prime $s;
  }
  @res;
}
sub additive_primes_split_sum0 {
  my @res;
  for( my $p = 2; $p <= $N ; $p = next_prime $p ) {
    push @res, $p if is_prime sum0 split //, $p;
  }
  @res;
}

