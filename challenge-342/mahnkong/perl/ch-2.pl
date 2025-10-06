use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($string) {
    my $max = 0;
    for (my $i = 1; $i < length($string); $i++) {
        my $left = () = substr($string, 0, $i) =~ /0/g;
        my $right = () = substr($string, $i, length($string)) =~ /1/g;
        my $current = $left + $right;
        $max = $current if $current > $max;
    }
    return $max;
}

is(run("0011"), 4, "Example 1");
is(run("0000"), 3, "Example 2");
is(run("1111"), 3, "Example 3");
is(run("0101"), 3, "Example 4");
is(run("011101"), 5, "Example 5");
