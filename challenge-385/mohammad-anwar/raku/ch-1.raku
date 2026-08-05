#!/usr/bin/env raku

use Test;

my @examples = (
    { in => ["apple banana apple", "banana orange"],     out => "orange" },
    { in => ["cat dog", "bird fish"],                    out => "bird cat dog fish" },
    { in => ["the quick brown fox", "the quick"],        out => "brown fox" },
    { in => ["hello", "hello"],                          out => "" },
    { in => ["blue blue red", "red green green yellow"], out => "yellow" },
);

is uncommon-words(|$_{<in>}), $_{<out>} for @examples;

done-testing;

sub uncommon-words($s1, $s2) {
    my %count;
    %count{$_}++ for "$s1 $s2".words;
    return %count.grep(*.value == 1).map(*.key).sort.join(' ');
}
