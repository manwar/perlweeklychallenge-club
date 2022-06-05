#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say "$_ -> @{[ gamma($_) ]}" for @ARGV;

sub gamma ($x) { exp(gammaln($x)) }

sub gammaln ($x) {
   die "bad argument in gammaln\n" if $x <= 0;

   state $cof = [
      57.1562356658629235,     -59.5979603554754912,
      14.1360979747417471,     -0.491913816097620199,
      .339946499848118887e-4,  .465236289270485756e-4,
      -.983744753048795646e-4, .158088703224912494e-3,
      -.210264441724104883e-3, .217439618115212643e-3,
      -.164318106536763890e-3, .844182239838527433e-4,
      -.261908384015814087e-4, .368991826595316234e-5
   ];

   my $y   = $x;
   my $tmp = $x + 5.24218750000000000;
   $tmp = ($x + 0.5) * log($tmp) - $tmp;
   my $ser = 0.999999999999997092;

   $ser += $_ / ++$y for $cof->@*;

   return $tmp + log(2.5066282746310005 * $ser / $x);
} ## end sub gammaln ($x)
