use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@list) {
    return scalar(map( $_ =~ /(^[aeiou]|[aeiou]$)/, @list));
}

is(run("unicode", "xml", "raku", "perl"), 2, "Example 1");
is(run("the", "weekly", "challenge"), 2, "Example 2");
is(run("perl", "python", "postgres"), 0, "Example 3");
