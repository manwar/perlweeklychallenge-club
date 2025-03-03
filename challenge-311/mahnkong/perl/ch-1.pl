use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    my $result;
    foreach my $c (split //, $str) {
        $result .= ($c =~ /[a-z]/ ? uc($c) : lc($c));
    }
    return $result;
}

is(run("pERl"), "PerL", "Example 1");
is(run("rakU"), "RAKu", "Example 2");
is(run("PyThOn"), "pYtHoN", "Example 3");
