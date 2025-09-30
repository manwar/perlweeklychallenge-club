use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($string, $char) {
    my $pos = index($string, $char);
    return $string if $pos == -1;
    return (reverse(substr($string, 0, $pos+1))) . substr($string, $pos+1, length($string));
}

is(run("programming", "g"), "gorpramming", "Example 1");
is(run("hello", "h"), "hello", "Example 2");
is(run("abcdefghij", "h"), "hgfedcbaij", "Example 3");
is(run("reverse", "s"), "srevere", "Example 4");
is(run("perl", "r"), "repl", "Example 5");
