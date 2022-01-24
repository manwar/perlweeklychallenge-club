#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $n = @ARGV ? $ARGV[0] : 20;

my @fib = (0,1,1);
my %fib = (0,1,1,1);

for(my $i=0; $n; $i++ ) {
  my $ds = 0;
  $ds+=$_ foreach split //,$i;
  if($ds>$fib[-1]) {
    ## If we dont have a large enough fib add the next one...
    ## Digit sum can only be 1 larger than current maximum
    ## fibonacci.
    push @fib, $fib[-2]+$fib[-1];
    $fib{$fib[-1]}=1;
  }
  next unless exists $fib{$ds};
  say $i;
  $n--;
}

