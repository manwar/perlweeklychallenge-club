use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';
use Time::Piece;

sub run($date) {
    my $time = Time::Piece->strptime($date,"%Y-%m-%d");
    return localtime($time)->[7] + 1;
}

is(run('2025-02-02'), 33, "Example 1");
is(run('2025-04-10'), 100, "Example 2");
is(run('2025-09-07'), 250, "Example 3");
