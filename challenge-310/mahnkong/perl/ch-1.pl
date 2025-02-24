use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@list) {
    return undef if scalar(@list) == 0;
    my $first = shift @list;

    foreach my $sublist (@list) {
        my %lookup = map { $_ => 1 } @$sublist;
        for (my $i = $#$first; $i >= 0; $i--) {
            splice(@$first, $i, 1) unless exists $lookup{$first->[$i]};
        }
    }
    return $first;
}

is_deeply(run(( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )), [1, 4], "Example 1");
is_deeply(run(( [1, 0, 2, 3], [2, 4, 5] )), [2], "Example 2");
is_deeply(run(( [1, 2, 3], [4, 5], [6] )), [], "Example 3");
