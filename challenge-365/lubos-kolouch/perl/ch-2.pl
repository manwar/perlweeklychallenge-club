#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub goal_parser {
    my ($str) = @_;

    $str =~ s/\(al\)/al/g;
    $str =~ s/\(\)/o/g;

    return $str;
}

is(goal_parser("G()(al)"), "Goal", "Example 1");
is(goal_parser("G()()()()(al)"), "Gooooal", "Example 2");
is(goal_parser("(al)G(al)()()G"), "alGalooG", "Example 3");

done_testing();
