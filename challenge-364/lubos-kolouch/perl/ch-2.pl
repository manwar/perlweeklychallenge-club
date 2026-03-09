#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

sub goal_parser {
    my ($str) = @_;

    # Order doesn't strictly matter as long as we match the longer sequences first if they are prefixes
    # G -> G (redundant replacement)
    # () -> o
    # (al) -> al

    $str =~ s/\(\)/o/g;
    $str =~ s/\(al\)/al/g;

    return $str;
}

# Tests
is(goal_parser("G()(al)"), "Goal", 'Example 1');
is(goal_parser("G()()()()(al)"), "Gooooal", 'Example 2');
is(goal_parser("(al)G(al)()()G"), "alGalooG", 'Example 3');

done_testing();
