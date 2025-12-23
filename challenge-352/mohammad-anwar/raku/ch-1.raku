#!/usr/bin/env raku

use Test;

my @examples = (
    {
        in  => ["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"],
        out => ["cat", "dog", "dogcat", "rat"],
    },
    {
        in  => ["hello", "hell", "world", "wor", "ellow", "elloworld"],
        out => ["hell", "world", "wor", "ellow"],
    },
    {
        in  => ["a", "aa", "aaa", "aaaa"],
        out => ["a", "aa", "aaa"],
    },
    {
        in  => ["flower", "flow", "flight", "fl", "fli", "ig", "ght"],
        out => ["flow", "fl", "fli", "ig", "ght"],
    },
    {
        in  => ["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"],
        out => ["car", "pet", "enter", "pen", "pent"],
    },
);

for @examples -> $example {
    is-deeply match-string(|$example<in>), $example<out>;
}

done-testing;

sub match-string(*@words) {
    my %seen;

    return @words.grep(-> $word {
        !%seen{$word}++ && @words.first(-> $other {
            $other ne $word && $other.contains($word)
        }).defined
    }).Array;
}
