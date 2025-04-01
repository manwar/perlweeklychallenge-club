use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($s1, $s2, $s3) {
    my $operations = 0;

    my $shortest = undef;
    foreach my $s ($s1, $s2, $s3) {
        my $l = length($s);
        $shortest = $l if !defined $shortest || $l <  $shortest;
    }

    foreach my $s ($s1, $s2, $s3) {
        if (length($s) > $shortest) {
            $operations += length($s) - $shortest;
            $s = substr($s, 0, $shortest);
        }
    }

    while ($s1 ne $s2 ne $s3) {
        foreach my $s ($s1, $s2, $s3) {
            $operations += 1;
            $s = substr($s, 0, length($s)-1);
        }
    }
    return ($s1 ? $operations : -1);
}

is(run("abc", "abb", "ab"), 2, "Example 1");
is(run("ayz", "cyz", "xyz"), -1, "Example 2");
is(run("yza", "yzb", "yzc"), 3, "Example 3");
