use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    my $longest = 0;
    while ($str =~ /(.)\1*/g) {
        $longest = length($&) if length($&) > $longest;
    }
    return $longest;
}

is(run("textbook"), 2, "Example 1");
is(run("aaaaa"), 5, "Example 2");
is(run("hoorayyy"), 3, "Example 3");
is(run("x"), 1, "Example 4");
is(run("aabcccddeeffffghijjk"), 4, "Example 5");
