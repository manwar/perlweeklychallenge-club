#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub decodeXor{
    my ($initial, $ref_encoded) = @_;
    my @decoded;
    push @decoded, $initial;

    for my $e (@{$ref_encoded}){
        push @decoded, $decoded[-1] ^ $e;
    }

    return \@decoded;
}

my @encoded1 = (1, 2, 3);
is_deeply(decodeXor(1, \@encoded1), [1, 0, 2, 1], "Test 1");
my @encoded2 = (6, 2, 7, 3);
is_deeply(decodeXor(4, \@encoded2), [4, 2, 0, 7, 4], "Test 2");

done_testing();
