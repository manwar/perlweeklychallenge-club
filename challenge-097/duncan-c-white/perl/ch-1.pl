#!/usr/bin/perl
#
# Task 1: "Caesar Cipher
# 
# You are given string $S containing alphabets A..Z only and a number $N.
# 
# Write a script to encrypt the given string $S using Caesar Cipher with
# left shift of size $N.
# 
# Example
# 
# 	Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
# 	Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
# 
# 	Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
# 	Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW
# 
# 	Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
# 	Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD
# 
# "
# 
# My notes: ah, the good old Caesar cipher, aka rotN..  easy.
# 

use strict;
use warnings;
use feature 'say';
use Data::Dumper;

die "Usage: caesar N S\n" unless @ARGV>=2;
my $n = shift;
my $s = join(' ', @ARGV);

die "caesar: N ($n) should be 1..25\n" unless $n>=1 && $n<=25;

$s =~ s/^\s+//;
$s =~ s/\s+$//;
$s =~ s/\s+/ /;
$s = uc($s);

# Going to use tr: build the alphabet and the replacement rotN alphabet 

my $alphabet = join( '', 'A'..'Z' );

# take last N letters of alphabet
my $last = substr($alphabet,26-$n);

# take first 26-N letters of alphabet
my $first = substr($alphabet,0,26-$n);

my $replace = $last.$first;

#say "first=$first, last=$last, replace=$replace";

# and then use eval via an old trick..
my $tr = eval "sub { tr/$alphabet /$replace / }" || die $@;
&$tr for $s;

say $s;
