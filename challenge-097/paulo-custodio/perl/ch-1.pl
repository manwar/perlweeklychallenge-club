#!/usr/bin/perl

# Challenge 097
#
# TASK #1 › Caesar Cipher
# Submitted by: Mohammad S Anwar
# You are given string $S containing alphabets A..Z only and a number $N.
#
# Write a script to encrypt the given string $S using Caesar Cipher with left
# shift of size $N.
#
# Example
# Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
# Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
#
# Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
# Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW
#
# Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
# Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD

use strict;
use warnings;
use 5.030;

@ARGV>=2 or die "Usage: ch-1.pl N WORDS...\n";
my($n, @words) = @ARGV;
say join " ", caeser($n, @words);

sub caeser {
    my($n, @words) = @_;
    my @output;
    for my $word (@words) {
        $word =~ s/\W//g;
        my @codes = map {(ord($_)-ord('A')+26-$n)%26} split //, uc($word);
        my @cipher = map {chr($_+ord('A'))} @codes;
        push @output, join "", @cipher;
    }
    return @output;
}
