#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => "pinnipeds",  out => "sdepinnipeds"  },
    { in => "abcd",       out => "dcbabcd"       },
    { in => "bananas",    out => "sananabananas" },
    { in => "dissident",  out => "tnedissident"  },
    { in => "cailliachs", out => "shcailliachs"  },
);

is convert_palindrome($_->{in}), $_->{out} foreach @examples;

done_testing;

sub convert_palindrome($str) {
    for my $len (reverse 1 .. length $str) {
        my $prefix = substr($str, 0, $len);
        return reverse(substr($str, $len)) . $str if $prefix eq reverse $prefix;
    }
}
