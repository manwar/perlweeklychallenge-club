#! /usr/bin/raku

use Test;

plan 3;

is-deeply(relativesort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6]), [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9], 'example 1');
is-deeply(relativesort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]), [1, 3, 3, 3, 2, 2, 4, 4, 6], 'example 2');
is-deeply(relativesort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]), [1, 1, 1, 0, 0, 3, 2, 4, 5], 'example 3');

sub relativesort(@list1, @list2) {
    my %c;
    @list1.map({%c{$_}++});
    my @out;
    for @list2 -> $i {
        @out.append(0+$i xx %c{$i} || 0);
        %c{$i}:delete;
    }
    for %c.keys.sort -> $i {
        @out.append(0+$i xx %c{$i})
    }
    return @out;
}
