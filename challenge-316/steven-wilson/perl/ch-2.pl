#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub subsequence{
    my ($sub, $full) = @_;
    my $position = 0;
    for my $char (split //, $sub){
        my $index = index($full, $char, $position);
        if ($index == -1){
            return 0;
        }
        $position = $index + 1;
    }
    return 1;
}

ok(subsequence("uvw", "bcudvew"), "Example 1");
ok(!subsequence("aec", "abcde"), "Example 2");
ok(subsequence("sip", "javascript"), "Example 3");
ok(subsequence("", ""), "Empty strings");
ok(subsequence("", "perl"), "Empty subsequence");
ok(!subsequence("a", ""), "Empty full sequence");

done_testing();
