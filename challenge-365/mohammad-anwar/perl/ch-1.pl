#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    { in => ["abc",  1], out => 6},
    { in => ["az",   2], out => 9},
    { in => ["cat",  1], out => 6},
    { in => ["dog",  2], out => 8},
    { in => ["perl", 3], out => 6},
);

is alphabet_index_digit_sum(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub alphabet_index_digit_sum {
    my ($s, $k) = @_;

    my $n = join "", map{ ord($_) - 96 } split "", $s;
    $n = eval join "+", split "", $n for 1..$k;
    return $n;
}
