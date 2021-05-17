#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;
use Benchmark qw(cmpthese);


open my $fh, q(<), 'ans.txt';
chomp( my @ans = <$fh> );
close $fh;

my $N = @ARGV     ? $ARGV[0] : 30;
my $I = @ARGV > 1 ? $ARGV[1] : 100_000;
my $cache;
my @glob_cache = (1,1);
my @str_cache  = (1,1);
#is(climb_cache_str(  $_), $ans[$_] ) foreach 0..1000; done_testing(); exit;

#if(0){
is(climb(            $_), $ans[$_] ) foreach 0..$N;
is(climb_str(        $_), $ans[$_] ) foreach 0..$N;
is(climb_cache(      $_), $ans[$_] ) foreach 0..$N;
is(climb_cache_glob( $_), $ans[$_] ) foreach 0..$N;
is(climb_cache_str(  $_), $ans[$_] ) foreach 0..$N;
is(climb_fib(        $_), $ans[$_] ) foreach 0..$N;
is(climb_fib_1liner( $_), $ans[$_] ) foreach 0..$N;
is(climb_fib_approx( $_), $ans[$_] ) foreach 0..$N;
is(climb_lookup(     $_), $ans[$_] ) foreach 0..$N;

done_testing();
#}

cmpthese($I,{
  'climb'  => sub { climb(            $_ ) foreach 0..$N; },
  'clim$'  => sub { climb_str(        $_ ) foreach 0..$N; },
  'cache'  => sub { climb_cache(      $_ ) foreach 0..$N; },
  'cach$'  => sub { climb_cache_str(  $_ ) foreach 0..$N; },
  'g-cch'  => sub { climb_cache_glob( $_ ) foreach 0..$N; },
  'look'   => sub { climb_lookup(     $_ ) foreach 0..$N; },
  'fib'    => sub { climb_fib(        $_ ) foreach 0..$N; },
  'fib-1'  => sub { climb_fib_1liner( $_ ) foreach 0..$N; },
  'fib-a'  => sub { climb_fib_approx( $_ ) foreach 0..$N; },
});

## Once we look at the formula for climb - we
## realise that the value is just the (n+1)th
## fibonachi sequence.. we have a formulae for
## that so we can forgo the loop...
##
## Note we add 0.001 as this avoids the problem of
## rounding down to a value of 1 less than the
## fibonachi number...
## infact rewriting this as a 1-liner even
## speeds it up futher - this is down to
## storing the caclulation of phi^(n+!) only
## temporarily
##
## Also we note that actually we can forgo this - by
## noting that the contribution to the fibonnaci
## value from the (1/phi)^n part is less than 1. So
## we can replace the formula with the approximation below.
##
## This works for all values of n>0;

sub climb {
  my($a,$b) = (1,1);
  ($a,$b) = ($b,$a+$b) foreach 2..$_[0];
  return $b;
}

sub climb_str {
  my($a,$b) = (1,1);
  ($a,$b) = ($b,str_add($a,$b)) foreach 2..$_[0];
  return $b;
}

sub climb_cache {
  state @cache = (1,1);
  $cache[$_]=$cache[$_-1]+$cache[$_-2] foreach @cache .. $_[0];
  return $cache[$_[0]];
}

sub str_add {
  my ( $a, $b ) = map { [split m{}, reverse $_] } @_;
  my $c = '';
  my $x = 0;
  while( @{$a} || @{$b} || $x ) {
    my $t = (shift @{$a}||0) + (shift @{$b}||0) + $x;
    $c = ($t%10).$c;
    $x = $t>9?1:0;
  }
  return $c;
}

sub climb_cache_str {
  $str_cache[$_] = str_add($str_cache[$_-1],$str_cache[$_-2]) foreach @str_cache .. $_[0];
  return $str_cache[$_[0]];
}

sub climb_cache_glob {
  $glob_cache[$_]=$glob_cache[$_-1]+$glob_cache[$_-2] foreach @glob_cache .. $_[0];
  return $glob_cache[$_[0]];
}

sub climb_fib {
  my $q = ((1 + sqrt 5)/2)**($_[0]+1);
  return int(0.001+ ($q - ($_[0]&1?1:-1)/$q)*sqrt 0.2);
}

sub climb_fib_1liner {
  return int(0.001 + (($a = ((1+sqrt 5)/2)**($_[0]+1)) - ($_[0]&1?1:-1)/$a)*sqrt 0.2);
}

sub climb_fib_approx {
  return int(0.4 + (0.5+sqrt 1.25)**($_[0]+1)*sqrt 0.2);
}

sub climb_lookup {
  return $ans[$_[0]];
}
