#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub smaller_than_current(@num1) {
    map { my $x = $_; scalar grep $_ < $x, @num1 } @num1
}

# Useful for large arrays with some values repeated.
sub smaller_than_current_fast(@num1) {
    my %cache;
    map { my $x = $_; $cache{$_} //= scalar grep $_ < $x, @num1 } @num1
}

use Test2::V0;
plan(2 * 5 + 1);

for my $smaller_than_current (\&smaller_than_current,
                              \&smaller_than_current_fast
) {
    is [$smaller_than_current->(6, 5, 4, 8)], [2, 1, 0, 3], 'Example 1';
    is [$smaller_than_current->(7, 7, 7, 7)], [0, 0, 0, 0], 'Example 2';
    is [$smaller_than_current->(5, 4, 3, 2, 1)], [4, 3, 2, 1, 0], 'Example 3';
    is [$smaller_than_current->(-1, 0, 3, -2, 1)], [1, 2, 4, 0, 3], 'Example 4';
    is [$smaller_than_current->(0, 1, 1, 2, 0)], [0, 2, 2, 4, 0], 'Example 5';
}

my @long = map int rand 1000, 1 .. 1_000;
is smaller_than_current(@long), smaller_than_current_fast(@long), 'same';

use Benchmark qw{ cmpthese };
cmpthese(-3, {
         naive     => sub { smaller_than_current(@long) },
         optimized => sub { smaller_than_current_fast(@long) },
});
