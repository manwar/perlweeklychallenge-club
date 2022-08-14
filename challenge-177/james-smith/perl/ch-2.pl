#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Math::Prime::Util qw(is_prime);
use Time::HiRes qw(time);

my $template = "%-10s  %15.9f %30s\n";
my $K = $ARGV[0]//20;
my $flag = $ARGV[1]//3;

if($flag & 1 ) {
  my($t0,$i,$t)=(time,0);
  for(1..$K) {
    (++$i)!~/0/ && is_prime( $t = $i.'0'.reverse$i ) ? say $t : redo;
  }
  warn sprintf $template, 'Simple:',time-$t0, $t;
}

if( $flag & 2 ) {
  my( $magnitude, $ones, $start, $count,       $result ) =
    (          1,     0,   time, $ARGV[0]//20, '-'     );
  O: while(1) {
    for my $first (1,3,7,9) {
      !/0/ && is_prime( $_ .= '0' . reverse $_ ) &&
      say  && ( --$count || ( $result = $_ ) && last O )
        for $first * $magnitude + $ones .. ( $first + 1 ) * $magnitude - 1;
    }
    $magnitude *= 10;
    $ones      *= 10;
    $ones++;
  }
  warn sprintf $template, 'Optimized:', time-$start, $result;
}
