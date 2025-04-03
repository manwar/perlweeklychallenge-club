#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub find_third{
    my ($sentence, $first, $second) = @_;
    my @thirds = $sentence =~ /(?=$first\s$second\s(\w+))/g;
    return \@thirds;
}

is_deeply(
    find_third(
        "Perl is a my favourite language but Python is my favourite too.",
        "my", "favourite"
    ),
    ["language", "too"],
    "Example 1"
);

is_deeply(
    find_third(
        "Barbie is a beautiful doll also also a beautiful princess.",
        "a", "beautiful"
    ),
    ["doll", "princess"],
    "Example 2"
);

is_deeply(
    find_third("we will we will rock you rock you.", "we", "will"),
    ["we", "rock"],
    "Example 3"
);

done_testing();
