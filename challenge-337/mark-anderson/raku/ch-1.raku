#!/usr/bin/env raku
use Test;

is-deeply stc(6,5,4,8),     (2,1,0,3);
is-deeply stc(7,7,7,7),     (0,0,0,0);
is-deeply stc(5,4,3,2,1),   (4,3,2,1,0);
is-deeply stc(-1,0,3,-2,1), (1,2,4,0,3);
is-deeply stc(0,1,1,2,0),   (0,2,2,4,0);

sub stc(+@nums)
{
    my %bag is Bag = @nums.Bag; 
    my @keys = %bag.keys.sort;
    my %map is Map = @keys Z=> [\+] 0, |%bag{@keys};
    %map{@nums}
}
