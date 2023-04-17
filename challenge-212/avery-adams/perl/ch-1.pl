#!/bin/perl

use strict;
use v5.28;

my @letters = split(//, shift);
my @jumps = @ARGV;
my @new_word;

foreach (my $i = 0; $i <= $#letters; $i++) {
    push @new_word, ord($letters[$i]) + $jumps[$i] < (uc($letters[$i]) eq $letters[$i] ? 91 : 123) ? chr(ord($letters[$i]) + $jumps[$i]) : chr(ord($letters[$i]) + $jumps[$i] - 26);
}
say @new_word;
