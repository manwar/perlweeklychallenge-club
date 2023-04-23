# The Weekly Challenge 213
# Task 1 Fun Sort
use v5.30.0;
use warnings;

sub fs {
    my @list = @_;
    my @elist = grep {!($_ % 2)} @list;
    my @olist = grep {$_ % 2} @list;
    return ((sort {$a<=>$b} @elist) , (sort {$a<=>$b} @olist));
}

use Test::More tests=>3;
use Test::Deep;
cmp_deeply [fs(1,2,3,4,5,6)], [2,4,6,1,3,5];
cmp_deeply [fs(1,2)], [2,1];
cmp_deeply [fs(1)], [1];
