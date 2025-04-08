use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str1, $str2) {
    $str1 =~ s/(.{1})/$1\{1\}.*?/g;
    return ($str2 =~ /$str1/ ? 1 : 0)
}

is(run("uvw", "bcudvew"), 1, "Example 1");
is(run("aec", "abcde"), 0, "Example 2");
is(run("sip", "javascript"), 1, "Example 3");
