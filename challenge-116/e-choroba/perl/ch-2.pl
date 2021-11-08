#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

sub sum_of_squares {
    my ($n) = @_;
    my $s = sqrt sum(map $_ * $_, split //, $n);
    return $s == int $s ? 1 : 0
}

use Test::More;

is sum_of_squares(34), 1, 'Example 1';
is sum_of_squares(50), 1, 'Example 2';
is sum_of_squares(52), 0, 'Example 3';

is sum_of_squares(1234567890123456966), 1, 'Larger (23*23)';

done_testing();
