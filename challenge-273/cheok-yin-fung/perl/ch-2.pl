# The Weekly Challenge 273
# Task 2 B After A
use v5.30.0;
use warnings;

sub ab {
    my $str = $_[0];
    my $ind = index($str, "b");
    my $ans = $ind >= 0 ? 1 : 0;
    my $ind_a = index($str, "a", $ind);
    $ans = $ans && ($ind_a >= 0 ? 0 : 1);
    return $ans;
}

use Test::More tests=>5;
ok ab("aabb");
ok !ab("abab");
ok !ab("aaa");
ok ab("bbb");
ok !ab("ccc");
