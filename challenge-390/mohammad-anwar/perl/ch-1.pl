#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => "2[3[a]]",      out => "aaaaaa"     },
    { in => "10[a]",        out => "aaaaaaaaaa" },
    { in => "a2[b]c3[d]e",  out => "abbcddde"   },
    { in => "2[a2[b]c]",    out => "abbcabbc"   },
    { in => "1[a]2[b3[c]]", out => "abcccbccc"  },
);

is decode_string($_->{in}), $_->{out} foreach @examples;

done_testing;

sub decode_string {
    my ($s) = @_;
    1 while $s =~ s/(\d+)\[([^\[\]]*)\]/$2 x $1/eg;
    return $s;
}
