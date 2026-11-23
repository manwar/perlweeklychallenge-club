#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );
use Syntax::Construct qw{ ^CAPTURE };

use Math::Prime::Util qw{ gcd lcm };

sub fractional_addition_subtraction($expr) {
    while ($expr =~ m{/.+/}) {
        $expr =~ s{ (-?[0-9]+)/([0-9]+) ([-+]) (-?[0-9]+)/([0-9]+)}{}x;
        my ($n1, $d1, $op, $n2, $d2) = @{^CAPTURE};
        die "Can't use 0 as a denominator" if 0 == $d1 || 0 == $d2;
        $n2 = -$n2 if '-' eq $op;

        my $d = lcm($d1, $d2);
        my $n = $n1 * $d / $d1 + $n2 * $d / $d2;
        my $g = gcd($n, $d);
        $_ /= $g for $n, $d;
        substr $expr, 0, 0, "$n/$d";
    }
    return $expr
}

use Test::More tests => 5 + 2;

is fractional_addition_subtraction('1/2+3/2'), '2/1', 'Example 1';
is fractional_addition_subtraction('-5/2-3/2'), '-4/1', 'Example 2';
is fractional_addition_subtraction('5/3-5/3'), '0/1', 'Example 3';
is fractional_addition_subtraction('10/10-1/10+2/5'), '13/10', 'Example 4';
is fractional_addition_subtraction('1/6+1/6+1/6'), '1/2', 'Example 5';

ok ! (eval { fractional_addition_subtraction('2/3+1/0') } ), 'Division by zero';
like $@, qr/^Can't use 0 as a denominator/, 'Exception';
