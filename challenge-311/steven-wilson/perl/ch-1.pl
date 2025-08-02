#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub upperLower{
    return join "", map { /[a-z]/ ? uc : lc } split //, shift;
}

is(upperLower("pERl"), "PerL", "pERl => PerL");
is(upperLower("rakU"), "RAKu", "rakU => RAKu");
is(upperLower("PyThOn"), "pYtHoN", "PyThOn => pYtHoN");

done_testing();
