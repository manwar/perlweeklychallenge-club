#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub find_words{
    my ($char, @list) = @_;
    my @indices = grep { index($list[$_], $char) != -1  } 0..$#list;
    return \@indices;
}

is_deeply(find_words("e", "the", "weekly", "challenge"), [0, 1, 2], "Example 1");
is_deeply(find_words("p", "perl", "raku", "python"), [0, 2], "Example 2");
is_deeply(find_words("b", "abc", "def", "bbb", "bcd"), [0, 2, 3], "Example 3");
done_testing();
