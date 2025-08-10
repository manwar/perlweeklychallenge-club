use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    if ($str =~ /(\d{4})-(\d{2})-(\d{2})/) {
        return sprintf("%b-%b-%b", $1, $2, $3);
    }
    return undef;
}

is(run('2025-07-26'), '11111101001-111-11010', "Example 1");
is(run('2000-02-02'), '11111010000-10-10', "Example 2");
is(run('2024-12-31'), '11111101000-1100-11111', "Example 3");
