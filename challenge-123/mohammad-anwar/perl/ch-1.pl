#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use List::Util qw(min);

is(ugly_number(1), 1);
is(ugly_number(7), 8);
is(ugly_number(10), 12);
is(ugly_number(150), 5832);

done_testing;

sub ugly_number {
    my ($n) = @_;

    return $n if ($n == 1);

    my $multiple_of = { 2 => 2, 3 => 3, 5 => 5 };
    my $index_of    = { 2 => 0, 3 => 0, 5 => 0 };

    my $next = 1;
    my $ugly_numbers = [ $next ];
    foreach my $i (1 .. $n-1) {
        $next = min(values %$multiple_of);
        $ugly_numbers->[$i] = $next;

        foreach my $k (keys %$multiple_of) {
            if ($next == $multiple_of->{$k}) {
                $index_of->{$k}++;
                $multiple_of->{$k} = $ugly_numbers->[$index_of->{$k}] * $k;
            }
        }
    }

    return $next;
}
