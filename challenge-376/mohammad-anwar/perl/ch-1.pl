#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    {
        in  => [ "a7", "f4" ],
        out => "true"
    },
    {
        in  => [ "c1", "a8" ],
        out => "false"
    },
    {
        in  => [ "b5", "h2" ],
        out => "false"
    },
    {
        in  => [ "f3", "h1" ],
        out => "true"
    },
    {
        in  => [ "a1", "g8" ],
        out => "false"
    },
);

is same_color(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub same_color {
    my ($c1, $c2) = @_;

    my $sum1 = (ord(substr($c1, 0, 1)) - 97) + substr($c1, 1);
    my $sum2 = (ord(substr($c2, 0, 1)) - 97) + substr($c2, 1);

    return ($sum1 % 2) == ($sum2 % 2)?("true"):("false");
}
