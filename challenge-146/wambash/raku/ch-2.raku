#!/usr/bin/env raku

multi sub parent (Rat $r where * > 1) {
    $r - 1
}

multi sub parent (Rat $r) {
    $r / (1-$r)
}

sub curious-fraction-tree (Rat $member) {
    $member, *.&parent ... 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is curious-fraction-tree(3/5), (3/5, 3/2, 1/2, 1);
    is curious-fraction-tree(4/3), (4/3, 1/3, 1/2, 1);
    is curious-fraction-tree(121/155), (121/155, 121/34, 87/34, 53/34, 19/34, 19/15, 4/15, 4/11, 4/7, 4/3, 1/3, 1/2, 1);
    done-testing;
}

multi MAIN ($member) {
    curious-fraction-tree $member
    andthen .map: *.nude.join: '/'
    andthen .put
}
