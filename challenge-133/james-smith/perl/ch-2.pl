#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Data::Dumper qw(Dumper);

my @primes    = (2,3);
my %ds;
my %comp;
my @t =  smith_numbers(@ARGV?$ARGV[0]:100);
print "@t\n";

sub smith_numbers {
  my $C = shift;
  my @sn = ();
  my $n = 4;
  while(1) {
    my @q = prime_factors($n);
    if( @q ) {
      my $t = sum_digits($n);
      $t-= sum_digits($_) foreach @q;
      unless($t) {
        push @sn, $n;
        return @sn if @sn==$C;
      }
    }
    $n++;
  }
}

sub sum_digits {
  return $ds{$_[0]} if exists $ds{$_[0]};
  my $t = 0;
  $t+= $_ foreach split //, $_[0];
  return $ds{$_[0]} = $t;
}

sub prime_factors {
  my $N = shift;
  my @factors;
  foreach (@primes) {
    return @{ $comp{$N} = [ $_, exists $comp{$N/$_}? @{$comp{$N/$_}} : $N/$_ ] } unless $N % $_;
  }
  push @primes,$N;
  return;
}

