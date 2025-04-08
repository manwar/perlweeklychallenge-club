#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub circular{
    my @words = @_;
    if ( scalar @words < 2){
        return 1;
    }
    for my $i (0..scalar @words - 2){
        if (substr($words[$i], -1) ne substr($words[$i+1], 0, 1)){
            return 0;
        }
    }
    return 1;
}

ok(circular("perl", "loves", "scala"), "Example 1");
ok(!circular("love", "the", "programming"), "Example 2");
ok(circular("java", "awk", "kotlin", "node.js"), "Example 3");

done_testing();
