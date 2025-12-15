#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

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

is_deeply(match_string(@{$_->{in}}), $_->{out}) for @examples;

done_testing;

sub match_string {
    my @words = @_;
    my %seen;

    return [ grep {
        my $word = $_;
        !$seen{$word}++ && grep {
            $_ ne $word && index($_, $word) >= 0
        } @words
    } @words ];
}

