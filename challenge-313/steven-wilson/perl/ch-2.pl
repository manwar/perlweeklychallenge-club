#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub reverseLetters {
    my $string = shift;
    my @alpha = grep { /[a-zA-Z]/ } split //, $string;
    return join "", map {/[a-zA-Z]/ ? pop @alpha : $_} split //, $string;
}

is(reverseLetters("p-er?l"), "l-re?p", "Example 1");
is(reverseLetters("wee-k!L-y"), "yLk-e!e-w", "Example 2");
is(reverseLetters("_c-!h_all-en!g_e"), "_e-!g_nel-la!h_c", "Example 3");
done_testing();
