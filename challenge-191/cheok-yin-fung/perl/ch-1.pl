# The Weekly Challenge 191
# Task 1 Twice Largest
use v5.30.0;
use List::Util qw/max all/;

sub remove {
    my @arr = $_[0]->@*;
    return [grep {$_ != $_[1]} @arr];
}

sub twice_l {
    my @list = @_;
    my $max = max @list;
    my @slist = remove([@list], $max)->@*;
    return 1 if all {$_*2 <= $max} @slist;
    return -1;
}

use Test::More tests=>4;
ok twice_l(1,2,3,4) == -1;
ok twice_l(1,2,0,5) == 1;
ok twice_l(2,6,3,1) == 1;
ok twice_l(4,5,2,3) == -1;
