use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    return ($str =~ /([a-z]+)[^a-z]*$/i) ? length($1) : 0;
}

is(run('The Weekly Challenge'), 9, "Example 1");
is(run('   Hello   World    '), 5, "Example 2");
is(run("Let's begin the fun"), 3, "Example 3");
is(run(" 3 "), 0, "Example 4");
is(run("  "), 0, "Example 5");
