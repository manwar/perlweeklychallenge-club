use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@list) {
    for (my $i = 0; $i < $#list; $i++) {
        return 0 if (substr($list[$i], -1, 1) ne substr($list[$i + 1], 0, 1));
    }
    return 1;
}

is(run("perl", "loves", "scala"), 1, "Example 1");
is(run("love", "the", "programming"), 0, "Example 2");
is(run("java", "awk", "kotlin", "node.js"), 1, "Example 3");
