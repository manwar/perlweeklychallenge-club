#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my($C,$I) = (100,100_000);
#say foreach sp_loop(100);exit;
cmpthese( 5, {
  'sp' => sub { semiprimes($I); },
  'sl' => sub { sp_loop(   $I); },
#  'sm' => sub { sp_map(    $I); },
});

sub sp_loop {
  my $N = shift;
  my @p; my %ph;
  my @sp;
  foreach my $t ( 2..$N ) {
    my $prime = 1;
    foreach(@p) {
      next if $t%$_;
      $prime = 0;
      (push @sp,$t) && (last) if exists $ph{$t/$_};
    }
    if( $prime ) {
      push @p,$t; $ph{$t}=1;
    }
  }
  @sp;
}

sub sp_map {
  my $N = shift;
  my @primes      = (2);
  my @semi_primes = (4);

  foreach my $p ( map { 1+2*$_ } 1..($N/4) ) {
    map { ($p%$_)||(next) } @primes;
    push @primes,$p;
    push @semi_primes,grep {$_<=$N} map{$p*$_} @primes;
  }
  sort {$a<=>$b} @semi_primes;
}

sub semiprimes {
  my $N = shift;
  my @primes      = (2);
  my @semi_primes = (4);

  foreach my $p ( map { 1+2*$_ } 1..($N/4) ) {
    map { ($p%$_)||(next) } @primes;
    push @primes,$p;
    ($p*$_>$N) ? (next) : (push @semi_primes,$p*$_) for @primes;
  }
  sort {$a<=>$b} @semi_primes;
}

