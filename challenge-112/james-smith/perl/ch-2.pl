#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);


open my $fh, q(<), 'ans.txt';
chomp( my @ans = <$fh> );
close $fh;

my $N = @ARGV     ? $ARGV[0] : 30;
my $I = @ARGV > 1 ? $ARGV[1] : 100_000;

is(climb(            $_), $ans[$_] ) foreach 1..$N;
is(climb_fib(        $_), $ans[$_] ) foreach 1..$N;
is(climb_fib_1liner( $_), $ans[$_] ) foreach 1..$N;

done_testing();

cmpthese($I,{
  'climb' => sub { climb(            $_ ) foreach 0..$N; },
  'fib-g' => sub { climb_fib_global( $_ ) foreach 0..$N; },
  'fib-1' => sub { climb_fib_1liner( $_ ) foreach 0..$N; },
  'fib'   => sub { climb_fib(        $_ ) foreach 0..$N; },
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

sub climb {
  my @climb = (1,1);
  @climb = ($climb[1],$climb[0]+$climb[1]) foreach 2..$_[0];
  return $climb[1];
}

my $p;
sub climb_fib_global {
  $p = ((1 + sqrt 5)/2)**($_[0]+1);
  return int(0.001+ ($p - ($_[0]&1?1:-1)/$p)*sqrt 0.2);
}

sub climb_fib {
  my $q = ((1 + sqrt 5)/2)**($_[0]+1);
  return int(0.001+ ($q - ($_[0]&1?1:-1)/$q)*sqrt 0.2);
}

sub climb_fib_1liner {
  return int(0.001 + (($p = ((1+sqrt 5)/2)**($_[0]+1)) - ($_[0]&1?1:-1)/$p)*sqrt 0.2);
}

