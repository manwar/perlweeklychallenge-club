#!/usr/bin/perl
# The Weekly Challenge 131
# Task 1 Consecutive Arrays
# Usage: ch-1.pl @array
use warnings;
use v5.24.0;
use Data::Dumper;
use Test::More tests => 4;
use Test::Deep;

my @arr = (1, 2, 3, 5, 6, 7, 9, 10, 11, 13, 15);
@arr = @ARGV if defined($ARGV[0]);

# $Data::Dumper::Indent = 0;
# $Data::Dumper::Terse = 1;
# say Dumper @{consec(@arr)};
#   DEFAULT OUTPUT: [1,2,3][5,6,7][9,10,11][13][15]

my @ans_str;
for (@{consec(@arr)}) {
    push @ans_str, "[". (join ", ", @{$_}) . "]";
}
say join ", ", @ans_str;



sub consec {
    my @a = @_;
    my @list = ([ $a[0] ],);
    for my $i (1..$#a) {
        if ($a[$i] == $a[$i-1] + 1) {
            push $list[-1]->@*, $a[$i];
        }
        else {
            push @list, [$a[$i]];
        }
    }
    return \@list;
}



cmp_deeply(
    consec(1, 2, 3, 6, 7, 8, 9),
    [[1, 2, 3], [6, 7, 8, 9]],
    "Example 1"    
);

cmp_deeply(
    consec(11, 12, 14, 17, 18, 19),
    [[11, 12], [14], [17, 18, 19]],
    "Example 2"
);

cmp_deeply(
    consec(2, 4, 6, 8),
    [( [2],[4],[6],[8] )],
    "Example 3"
);

cmp_deeply(
    consec(1, 2, 3, 4, 5),
    [[1, 2, 3, 4, 5]],
    "Example 4"
);
