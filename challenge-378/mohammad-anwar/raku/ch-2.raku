#!/usr/bin/env raku

use Test;

my @examples = (
    { in  => ["acb", "cba",  "cdb"],   out => "true"  },
    { in  => ["aab", "aac",  "ad" ],   out => "true"  },
    { in  => ["bc",  "je",   "jg" ],   out => "false" },
    { in  => ["a",   "aaaa", "aa" ],   out => "true"  },
    { in  => ["c",   "d",    "h"  ],   out => "false" },
);

is sum_of_words(|$_<in>), $_<out> for @examples;

done-testing;

sub sum_of_words(*@words) {
    my @nums = @words.map: { Int( S:g/./{ ($/.ord - 97).Str }/ ) };
    return @nums[0] + @nums[1] == @nums[2] ?? "true" !! "false";
}
