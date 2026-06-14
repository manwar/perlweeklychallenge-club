#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    { in  => "abcba",   out => "true"  },
    { in  => "racecar", out => "true"  },
    { in  => "abcd",    out => "false" },
    { in  => "banana",  out => "true"  },
    { in  => "hello",   out => "true"  },
);

is reverse_substr_exists($_->{in}), $_->{out} foreach @examples;

done_testing;

sub reverse_substr_exists {
    my ($str) = @_;

    my $rev = reverse $str;
    for my $i (0 .. length($str) - 2) {
        my $sub = substr($str, $i, 2);
        return "true" if index($rev, $sub) != -1;
    }

    return "false";
}
