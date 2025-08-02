use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my @result;
    my %ints = map { $_ => 1 } @ints;

    for (my $i = 1; $i <= scalar(@ints); $i++,) {
        push @result, $i unless exists $ints{$i};
    }
    return [ @result ];
}

is_deeply(run(1, 2, 1, 3, 2, 5), [4, 6], "Example 1");
is_deeply(run(1, 1, 1), [2, 3], "Example 2");
is_deeply(run(2, 2, 1), [3], "Example 3");
