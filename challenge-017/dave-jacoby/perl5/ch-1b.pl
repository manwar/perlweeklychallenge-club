#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Here we use two wonderful modules that we have because the Perl community
# is wonderful and helpful. 

# The first is Memoize, which I learned about from Higher Order Perl.
# It handles saving the output of a subroutine for you, so that 
# the second call with the same values is pre-computed and faster. 
#   https://metacpan.org/pod/Memoize

# The second is Benchmark, which allows you to compare two functions
# (or, in this case, the same function with and without memoization)
# so we can tell which is faster.
#   https://metacpan.org/pod/Benchmark

use Benchmark qw{ timethese };
use Memoize;
memoize('a2');

# To maximize the differences, we are running this a million times
# against each. 

timethese( 1_000_000 , {
    'plain' => sub { a(2,5) },
    'memo'  => sub { a2(2,5) },
});

exit;

# a2() is the same as a(), except for the memoization step above.

sub a2 ( $m, $n ) {
    die 'Invalid input' unless $m >= 0 && $n >= 0;
    return $n + 1 if $m == 0;
    return a( $m - 1, 1 ) if $m > 0 && $n == 0;
    return a( $m - 1, a( $m, $n - 1 ) ) if $m > 0 && $n > 0;
}

sub a ( $m, $n ) {
    die 'Invalid input' unless $m >= 0 && $n >= 0;
    return $n + 1 if $m == 0;
    return a( $m - 1, 1 ) if $m > 0 && $n == 0;
    return a( $m - 1, a( $m, $n - 1 ) ) if $m > 0 && $n > 0;
}

__DATA__

And here I run it.

$ ./ackerman_memo.pl 
Benchmark: timing 1000000 iterations of memo, plain...
      memo:  4 wallclock secs ( 2.96 usr +  0.00 sys =  2.96 CPU) @ 337837.84/s (n=1000000)
     plain: 45 wallclock secs (45.41 usr +  0.00 sys = 45.41 CPU) @ 22021.58/s (n=1000000)

Looking at CPU time on this example (which is fairly small), we get a 15x speed increase
with memoization.
