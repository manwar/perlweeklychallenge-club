#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum0 };
use Math::Prime::Util qw{ is_prime };

sub prime_step($str) {
    my $sum = sum0(map ord, split //, $str);
    my $step = 0;

    ++$step until is_prime($sum + $step) || is_prime($sum - $step);
    return $step
}

use Test::More tests => 5 + 1;

is prime_step('hello'), 9, 'Example 1';
is prime_step('football'), 2, 'Example 2';
is prime_step('a'), 0, 'Example 3';
is prime_step('challenge'), 2, 'Example 4';
is prime_step('perl'), 2, 'Example 5';

is prime_step(""), 2, 'Empty string';
