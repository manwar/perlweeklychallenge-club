#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    {
        in  => "",
        out => ""
    },
    {
        in  => "reverse the given string",
        out => "gnirts nevig eht esrever"
    },
    {
        in  => "Perl is Awesome",
        out => "emosewA si lreP"
    },
    {
        in  => "v1.0.0-Beta!",
        out => "!ateB-0.0.1v"
    },
    {
        in  => "racecar",
        out => "racecar"
    },
);

is reverse_string($_->{in}), $_->{out} foreach @examples;

done_testing;

sub reverse_string {
    my ($str) = @_;

    my @chars = split('', $str);
    my $_str  = '';

    for (my $i = $#chars; $i >= 0; $i--) {
        $_str .= $chars[$i];
    }

    return $_str;
}
