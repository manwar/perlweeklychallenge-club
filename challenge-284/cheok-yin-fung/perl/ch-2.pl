# The Weekly Challenge 284
# Task 2 Relative Sort

use v5.30;
use warnings;

sub rs {
    my @list1 = $_[0]->@*;
    my @list2 = $_[1]->@*;
    my %ord;
    for my $i (0..$#list2) {
        $ord{$list2[$i]} = $i;
    }
    for my $k (@list1) {
        $ord{$k} = $#list2 + 1 if !defined($ord{$k});
    }
    my @lst = sort {$ord{$a}<=>$ord{$b} || $a <=> $b} @list1;
    return [@lst];
}

use Test2::V0;
is(
    rs([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], 
        [2, 1, 4, 3, 5, 6]),
    [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9]
);

is(
    rs([3, 3, 4, 6, 2, 4, 2, 1, 3],
        [1, 3, 2]),
    [1, 3, 3, 3, 2, 2, 4, 4, 6]
);

is(
    rs([3, 0, 5, 0, 2, 1, 4, 1, 1],
        [1, 0, 3, 2]),
    [1, 1, 1, 0, 0, 3, 2, 4, 5]
);
done_testing();
