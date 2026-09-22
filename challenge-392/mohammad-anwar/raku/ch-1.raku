#!/usr/bin/env raku

use Test;

my @examples = [
    { in => "pinnipeds",  out => "sdepinnipeds"  },
    { in => "abcd",       out => "dcbabcd"       },
    { in => "bananas",    out => "sananabananas" },
    { in => "dissident",  out => "tnedissident"  },
    { in => "cailliachs", out => "shcailliachs"  },
];

is convert-palindrome($_{<in>}), $_{<out>} for @examples;

done-testing;

sub convert-palindrome(Str $str) {
    for (1 .. $str.chars).reverse -> $len {
        my $prefix = $str.substr(0, $len);
        return $str.substr($len).flip ~ $str if $prefix eq $prefix.flip;
    }
}
