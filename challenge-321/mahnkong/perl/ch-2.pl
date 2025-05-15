use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub analyze($str) {
    my @buffer;
    foreach my $c (split //, $str) {
        if ($c eq '#') {
            pop @buffer if scalar(@buffer) > 0;
        } else {
            push @buffer, $c;
        }
    }
    return join('', @buffer);
}

sub run($str1, $str2) {
    return analyze($str1) eq analyze($str2) ? 1 : 0;
}

is(run("ab#c", "ad#c"), 1, "Example 1");
is(run("ab##", "a#b#"), 1, "Example 1");
is(run("a#b", "c"), 0, "Example 1");
