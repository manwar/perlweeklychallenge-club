#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    { in  => ["acb", "cba",  "cdb"],   out => "true"  },
    { in  => ["aab", "aac",  "ad" ],   out => "true"  },
    { in  => ["bc",  "je",   "jg" ],   out => "false" },
    { in  => ["a",   "aaaa", "aa" ],   out => "true"  },
    { in  => ["c",   "d",    "h"  ],   out => "false" },
);

is sum_of_words(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub sum_of_words {
    my @nums = map { int( s/./ord($&)-97/ger ) } @_;
    return $nums[0] + $nums[1] == $nums[2] ? "true" : "false";
}
