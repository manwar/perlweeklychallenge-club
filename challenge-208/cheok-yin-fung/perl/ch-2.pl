# The Weekly Challenge 208
# Task 2 Duplicate and Missing
# Assume the array has three or more elements.
use v5.30.0;
use warnings;
use List::MoreUtils qw/slide/;

sub aindex {
    my $item = $_[0];
    my @list = $_[1]->@*;
    for my $i (0..$#list) {
        return $i if $item == $list[$i];
    }
    return undef;
}

sub dm {
    my @arr = @_;
    my $dup, my $mis;
    my $locator;
    $locator = $arr[0]!=$arr[1] ? $arr[0] : $arr[-1];
    my $ref_ind = $locator==$arr[0] ? 0 : $#arr;
    my $shft = $locator-$ref_ind;
    for my $i (0..$#arr) {
        if ($shft+$i != $arr[$i]) {
            ($dup, $mis) = ($arr[$i], $shft+$i);
            last;
        }
    }
    return [$dup, $mis] if defined($dup);
    return -1;
}

use Test::More tests=>5;
use Test::Deep;
cmp_deeply dm(1,2,2,4), [2,3];
cmp_deeply dm(1,2,3,4), -1;
cmp_deeply dm(1,2,3,3), [3,4];
cmp_deeply dm(2,2,3), [2,1];
cmp_deeply dm(3,3,4), [3,2];
