#!/usr/bin/env perl
#
# ch-1.pl - Survivor
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

say survivor(shift) and exit if @ARGV;

# Linked list solution
sub survivor {
    my $N = shift;
    my @ll = (undef, 2..$N, 1); # Circular linked list
    my $cur = 1;
    $ll[$cur] = $ll[$ll[$cur]], $cur = $ll[$cur] until $ll[$cur] == $cur;

    $cur;
}

sub analytic {
    my $N = shift;
    2 * ($N - 2**int( log($N) / log(2) )) + 1;
}

#
# Benchmarking and Tests
#

use Benchmark qw/cmpthese/;
use Test::More;

cmpthese(-5, {
    linked      => sub { survivor($_) for 1..100 },
    analytic    => sub { analytic($_) for 1..100 },
});

is survivor(100), 73;
is survivor(50), 37;
is survivor($_), analytic($_) for 1..100;
done_testing;
