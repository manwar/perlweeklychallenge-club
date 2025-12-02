use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    my $substring_length = 3;
    my $good_substrings = 0;

    for (my $i = 0; $i < length($str) - $substring_length + 1; $i++) {
        my %chars;
        for my $c (split //, substr($str, $i, $substring_length)) {
            $chars{$c} = undef;
        }
        $good_substrings += 1 if scalar(keys(%chars)) == $substring_length;
    }
    return $good_substrings;
}

is(run("abcaefg"), 5, "Example 1");
is(run("xyzzabc"), 3, "Example 2");
is(run("aababc"), 1, "Example 3");
is(run("qwerty"), 4, "Example 4");
is(run("zzzaaa"), 0, "Example 5");
