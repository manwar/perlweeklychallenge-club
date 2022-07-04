#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $N = @ARGV?$ARGV[0]:20;

if( $N > 0 ) {
  compact($N);
} else {
  expanded(-$N);
}

# As an array we don't need to keep the fibonacci numbers
# We need them as the keys to the hash %fib which we use
# to check that a digit sum is a fibonacci number. Instead
# We only keep the last two values $fa & $fb

## If we dont have a large enough fib for the digit sum
## add the next one...
## Digit sum can only be 1 larger than current maximum
## fibonacci so only need to add 1...

sub compact {
  for( my($n,$ds,$i,$fa,$fb,%fib)=($_[0],0,0,1,1,0,1,1,1);
       $n; $i++,$ds=0 ) {
    $ds+=$_ for split //,$i;
    ($fib{$fa+$fb},$fa,$fb)=(1,$fb,$fa+$fb) if $ds > $fb;
    $n--,say $i if exists $fib{$ds};
  }
}

sub expanded {
  my $n = $_[0];
  my ( $fa, $fb ) = (1,1);
  my %fib = ( 0 => 1, 1 => 1 );
  my $i = 0;

  while($n) {
    my $ds = 0;
    $ds += $_ for split //, $i;
    if($ds > $fb) {
      ( $fa, $fb ) = ( $fb, $fa + $fb );
      $fib{ $fb } = 1;
    }
    if( exists $fib{$ds} ) {
      $n--;
      say $i;
    }
    $i++;
  }
}

