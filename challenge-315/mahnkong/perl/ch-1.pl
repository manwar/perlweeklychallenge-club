use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($list, $char) {
    my $result = [];

    for (my $i = 0; $i < scalar(@$list); $i++) {
        push @$result, $i if $list->[$i] =~ /$char/;
    }
    return $result;
}

is_deeply(run(["the", "weekly", "challenge"], "e"), [0, 1, 2], "Example 1");
is_deeply(run(["perl", "raku", "python"], "p"), [0, 2], "Example 2");
is_deeply(run(["abc", "def", "bbb", "bcd"], "b"), [0, 2, 3], "Example 3");
