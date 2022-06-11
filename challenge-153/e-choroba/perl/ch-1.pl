#!/usr/bin/perl
use warnings;
use strict;

use experimental 'signatures';

use List::Util qw{ sum product };

sub factorial ($n) {
    product(1, 1 .. $n)
}

sub left_factorial ($n) {
    sum(map factorial($_), 0 .. $n - 1)
}

{   my %F;
    sub factorial_m ($n) {
        $F{$n} //= product(1, 1 .. $n)
    }
}

{   my %LF = (1 => 1);
    sub left_factorial_m ($n) {
        $LF{$n} //= left_factorial_m($n - 1) + factorial_m($n - 1)
    }
}

use Test::More tests => 22;

is left_factorial(1), 1;
is left_factorial(2), 2;
is left_factorial(3), 4;
is left_factorial(4), 10;
is left_factorial(5), 34;
is left_factorial(6), 154;
is left_factorial(7), 874;
is left_factorial(8), 5914;
is left_factorial(9), 46234;
is left_factorial(10), 409114;

is left_factorial(20), 128425485935180314;

is left_factorial_m($_), left_factorial($_) for 1 .. 10, 20;

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    plain    => 'left_factorial(10)',
    memoized => 'left_factorial_m(10)',
});

__END__

              Rate    plain memoized
plain     332153/s       --     -96%
memoized 9473789/s    2752%       --
