use strict;
use warnings;
use List::Util qw(first);

sub split_list {
    my ($list_ref, $size) = @_;
    my @list = sort {$a <=> $b} @$list_ref;
    my @result;
    while (@list) {
        my @group = shift @list;
        for (1 .. $size - 1) {
            my $index = first { $list[$_] == $group[-1] + 1 } 0 .. $#list;
            if (defined $index) {
                push @group, splice(@list, $index, 1);
            } else {
                return -1;
            }
        }
        push @result, \@group;
    }
    return \@result;
}

use Test::More tests => 4;

is_deeply(split_list([1,2,3,5,1,2,7,6,3], 3), [[1, 2, 3], [1, 2, 3], [5, 6, 7]]);
is_deeply(split_list([1,2,3], 2), -1);
is_deeply(split_list([1,2,4,3,5,3], 3), [[1, 2, 3], [3, 4, 5]]);
is_deeply(split_list([1,5,2,6,4,7], 3), -1);
