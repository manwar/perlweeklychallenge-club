#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Data::Dumper qw(Dumper);
use Math::Prime::Util qw(is_prime primes);

my @TESTS = (
   [ 5,2],     [4,2], [18,2], [19,3], [100,9],
   [40,5],  [328,15], [96,2], [97,3], [100,4],
  [129,10], [160,11],
);

my @t;
say "***  @{$_}\n", _dump( first_partition(@{$_}) ), "\n--\n", _dump( partition(@{$_}) ), "\n" for @TESTS;

if(0){
say '===============================';
for my $s (1..200) { printf '%4d',scalar(@t = partition($s,$_)) for 1..12; say ''; }
say '===============================';
for my $s (1..15) { (@t=partition($_,$s)) ? ( print int(log@t/log 4) ) : print ' ' for 1..320; say ''; }
say '===============================';
}

sub partition {
  my ( $m, $n, $p ) = (@_,0);
  $n > 1
  ? map { $p = $_;
          map { [ $p, @{$_} ] }
              partition( $m-$p, $n-1, $p )
        } @{ primes $p+1, int( ($m-$n/2+1/2)/$n)  }
  : $m > $p && is_prime $m ? [$m] : ();
}

sub first_partition {
  my ( $m, $n, $p ) = (@_,0);
  $n > 1
  ? map { $p = $_;
          map { return [$p, @{$_}] }
              first_partition( $m-$p, $n-1, $p )
        } @{ primes $p+1, int( ($m-$n/2+1/2)/$n)  }
  : $m > $p && is_prime $m ? [$m] : ();
}

sub _dump {
  @_ ? join ',  ', map { '[ '. join(', ', @{$_}).' ]' } @_ : '-- no solutions --';
}
