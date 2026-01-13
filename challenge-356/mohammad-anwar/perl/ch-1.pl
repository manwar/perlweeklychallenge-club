#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    { in => 4, out => 2 },
    { in => 5, out => 3 },
    { in => 6, out => 3 },
    { in => 7, out => 4 },
    { in => 8, out => 4 },
);

is count_one($_->{in}), $_->{out} for @examples;

done_testing;

sub count_one {
    my ($n) = @_;

    my @k = (1,2,2);
    my $i = 2;
    push @k, ($k[-1] ^ 3) x $k[$i++] while @k < $n;
    my $s = join("",@k[0..$n-1]);
    return $s =~ tr/1//;
}
