#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    { in => [42,         2], out => "101010" },
    { in => [15642094,  16], out => "EEADEE" },
    { in => [493,        8], out => "755"    },
    { in => [2228519,   36], out => "1BRJB"  },
    { in => [123456789, 64], out => "7MyqL"  },
);

is to_base(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub to_base {
    my ($n, $b) = @_;
    my @d = ('0'..'9', 'A'..'Z', 'a'..'z', '+', '/');
    return $n ? to_base(int($n / $b), $b) . $d[$n % $b] : '';
}
