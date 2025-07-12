use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    my $longest = "";

    for my $c ("a" .. "z") {
        my $uc = uc($c);
        while ($str =~ /($c+)/gi) {
            my $m = $1;
            $longest = $m if $m =~ /$c/ && $m =~ /$uc/ && length($m) > length($longest);
        }
    }
    return $longest;
}

is(run("YaaAho"), "aaA", "Example 1");
is(run("cC"), "cC", "Example 2");
is(run("A"), "", "Example 3");
is(run("cCaaaa"), "cC", "Example 4");
