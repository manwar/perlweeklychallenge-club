#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub arraysIntersection{
    my $ref = shift;
    my %hash = ();
    for my $array (@$ref){
        for my $key (getSet($array)){
            $hash{$key}++;
        }
    }
    return sort { $a <=> $b } grep { $hash{$_} == scalar @$ref } keys %hash;
}

sub getSet{
    my $ref = shift;
    my %hash = ();
    for my $key (@$ref){
        $hash{$key}++;
    }
    return keys %hash;
}

my $list1 = [[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]];
is_deeply([arraysIntersection( $list1 )], [1, 4], "Example 1");

my $list2 = [[1, 0, 2, 3], [2, 4, 5]];
is_deeply([arraysIntersection( $list2 )], [2], "Example 2");

my $list3 = [[1, 2, 3], [4, 5], [6]];
is_deeply([arraysIntersection( $list3 )], [], "Example 3");

done_testing();
