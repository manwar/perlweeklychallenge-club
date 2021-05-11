#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

open my $fh, q(<), 'ans.txt';
chomp( my @ans = <$fh> );
close $fh;
my $N = @ARGV ? $ARGV[0] : 50;
my $I = @ARGV > 1 ? $ARGV[1] : 10_000;

is(climb_fib(1),1);
is(climb_fib(2),2);
is(climb_fib(3),3);
is(climb_fib(4),5);
is(climb_fib(5),8);
is(climb_fib(6),13);
is(climb_fib(7),21);
is(climb_fib(8),34);
is(climb_fib(9),55);
is(climb_fib(10),89);

is(climb(1),1);
is(climb(2),2);
is(climb(3),3);
is(climb(4),5);
is(climb(5),8);
is(climb(6),13);
is(climb(7),21);
is(climb(8),34);
is(climb(9),55);
is(climb(10),89);

is( climb_fib_1liner($_),$ans[$_] ) foreach 1..50;
done_testing();

cmpthese($I,{
  'climb' => sub { climb($_) foreach 0..$N; },
  'fib-1' => sub { climb_fib_1liner($_) foreach 0..$N; },
  'fib'   => sub { climb_fib($_) foreach 0..$N; },
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
## storing the caclulation of phi only temporarily

sub climb_fib {
  my $p = ((1 + sqrt 5)/2)**($_[0]+1);
  return int(0.001+ ($p - ($_[0]&1?1:-1)/$p)*sqrt 0.2);
}

sub climb_fib_1liner {
  return int(0.001 + (($a = ((1+sqrt 5)/2)**($_[0]+1)) - ($_[0]&1?1:-1)/$a)*sqrt 0.2);
}

sub climb {
  my @climb = (1,1);
  @climb = ($climb[1],$climb[0]+$climb[1]) foreach 2..$_[0];
  return $climb[1];
}

