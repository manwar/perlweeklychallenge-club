use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($source, $target) {
    my $target_string = join("", @$target);
    foreach my $string (map { join ("", @{$_}) } @$source) {
        $target_string =~ s/$string//;
    }
    return length($target_string) == 0 ? 1 : 0;
}

is(run([[2,3], [1], [4]], [1, 2, 3, 4]), 1, "Example 1");
is(run([[1,3], [2,4]], [1, 2, 3, 4]), 0, "Example 2");
is(run([[9,1], [5,8], [2]], [5, 8, 2, 9, 1]), 1, "Example 3");
is(run([[1], [3]], [1, 2, 3]), 0, "Example 4");
is(run([[7,4,6]], [7, 4, 6]), 1, "Example 5");
