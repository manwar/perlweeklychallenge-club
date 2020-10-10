#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ first };

sub missing {
    my ($n) = @_;
    my ($max, %uniq) = $n->[0];
    for my $i (grep $_ > 0, @$n) {
        $max = $i if $i > $max;
        undef $uniq{$i}
    }
    return first { ! exists $uniq{$_} } 1 .. $max + 1
}

use Test::More;

is missing([5, 2, -2, 0]),
1,
'Example 1';

is missing([1, 8, -1]),
2,
'Example 2';

is missing([2, 0, -1]),
1,
'Example 3';

is missing([5 .. 100]),
1,
'missing 1';

is missing([1 .. 100]),
101,
'max + 1';

is missing([(1 .. 5) x 20]),
6,
'duplicates max + 1';

is missing([(2 .. 6) x 20]),
1,
'1 below duplicates';

is missing([5, 5, 4, 4, 2, 2, 1, 1]),
3,
'duplicates middle';

done_testing();

