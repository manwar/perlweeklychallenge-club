use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@words) {
    @words = reverse(@words);
    while (1) {
        my $max_index = $#words;
        for (my $i = $max_index; $i > 0; $i--) {
            if (join('', sort(split(//, $words[$i]))) eq join('', sort(split(//, $words[$i-1])))) {
                splice(@words, $i, 1);
            }
        }
        last if $max_index == $#words;
    }
    return scalar(@words);
}

is(run("acca", "dog", "god", "perl", "repl"), 3, "Example 1");
is(run("abba", "baba", "aabb", "ab", "ab"), 2, "Example 2");
