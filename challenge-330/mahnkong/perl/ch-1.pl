use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    $str =~ s/\D?\d// while $str =~ /\D?\d/;
    return $str;
}

is(run('cab12'), 'c', "Example 1");
is(run('xy99'), '', "Example 2");
is(run('pa1erl'), 'perl', "Example 3");
is(run('ab132x'), 'x', "Example 4");
