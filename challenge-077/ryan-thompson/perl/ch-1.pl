#!/usr/bin/env perl
#
# ch-1.pl - Fibonacci Sum
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.016;
use warnings;
use strict;
no warnings 'uninitialized';

my $N = shift // die "Usage: $0 <integer>\n";

my @fib = (1,2);
push @fib, $fib[-1] + $fib[-2] while $fib[-1] < $N;
pop @fib if $fib[-1] > $N;

sub {
    my $n = shift;

    return say join(" + ", @_) . " == $N" if $n == 0;

    __SUB__->($n-$_, @_, $_) for grep { $_ <= $n and $_ > $_[-1] } @fib;

}->($N);
