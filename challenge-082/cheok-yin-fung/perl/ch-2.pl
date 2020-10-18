#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 6;

sub interleave {
    return 
       interleave_one_side($_[0], $_[1], $_[2]) 
        ||
       interleave_one_side($_[1], $_[0], $_[2]) 
}

sub interleave_one_side {
    my $A = $_[0];
    my $B = $_[1];
    my $C;
    my $possibleinterleave = undef;
    my $pos_AinC = 0;
    do {
        $C = $_[2];      #effect of substr modify $C 
        $pos_AinC = index($C,$A,$pos_AinC);
        if ($pos_AinC != -1) {
            substr($C, $pos_AinC, length $A, "");
            if ($C eq $B) {
                $possibleinterleave = 1;
            } 
            else {
                $pos_AinC++;
            }
        }
    } while ($pos_AinC != -1  and
                $pos_AinC < length($C) and
                !$possibleinterleave);
    return $possibleinterleave;
}

if ($ARGV[2]) {
    if (interleave($ARGV[0], $ARGV[1], $ARGV[2])) {
        print 1, "\n";
    }
    else {
        print -1, "\n";
    }
} 
else {
    die "I need three input parameters."
}


ok interleave("XY", "X", "XXY"), "example 1";
ok interleave("XXY", "XXZ", "XXXXZY"), "example 2";
ok !interleave("YX", "X", "XXY"), "example 3";
ok interleave("alpha", "beta", "alphabeta"), "alphabeta";
ok interleave("alphabeta", "alpha", "alphabealphata"), "alphabealphata";
ok interleave("abcd", "ab", "abcabd"), "a..b";
