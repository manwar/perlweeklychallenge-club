use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($ints, $r, $c) {
    my $result = [];
    my @row;
    for (my $i = 0; $i < scalar(@$ints); $i++) {
        push @row, $ints->[$i];
        if (scalar(@row) == $c) {
            push @$result, [@row];
            last if (scalar(@$result) == $r);
            @row=();
        }
    }
    return $result;
}

is_deeply(run([1, 2, 3, 4], 2, 2), [[1, 2], [3, 4]], "Example 1");
is_deeply(run([1, 2, 3], 1, 3), [[1, 2, 3]], "Example 2");
is_deeply(run([1, 2, 3, 4], 4, 1), [[1], [2], [3], [4]], "Example 3");
is_deeply(run([1, 2, 3, 4], 3, 1), [[1], [2], [3]], "Example 4");
