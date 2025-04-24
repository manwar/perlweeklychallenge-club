use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($source, $target) {
    return 0 if $#$source != $#$target;
    my $diff = 0;
    for (my $i = 0; $i < scalar(@$source); $i++) {
        $diff += 1 if $source->[$i] != $target->[$i];
    }
    return $diff <= 2 ? 1 : 0;
}

is(run([3, 2, 1, 4], [1, 2, 3, 4]), 1, "Example 1");
is(run([1, 3, 4], [4, 1, 3]), 0, "Example 2");
is(run([2], [2]), 1, "Example 3");
