use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($string) {
    my $old;
    do {
        $old = $string;
        $string =~ s/([A-Za-z])\1//g;
    } while ($old ne $string);
    return $string;
}

is(run("abbaca"), "ca", "Example 1");
is(run("azxxzy"), "ay", "Example 2");
is(run("aaaaaaaa"), "", "Example 3");
is(run("aabccba"), "a", "Example 4");
is(run("abcddcba"), "", "Example 5");
