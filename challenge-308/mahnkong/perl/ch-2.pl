use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($encoded, $initial) {
    my $original = [$initial];
    foreach my $e (@$encoded) {
        push @$original, $e ^ $original->[-1];
    }
    return $original;
}

is_deeply(run([1, 2, 3], 1), [1, 0, 2, 1], "Example 1");
is_deeply(run([6, 2, 7, 3], 4), [4, 2, 0, 7, 4], "Example 2");
