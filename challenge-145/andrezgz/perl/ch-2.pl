#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-145/
# Task #2 > Palindromic Tree
#
# You are given a string $s.
#
# Write a script to create a Palindromic Tree for the given string.
#
# I found this blog exaplaining Palindromic Tree in detail.
# https://medium.com/@alessiopiergiacomi/eertree-or-palindromic-tree-82453e75025b
#
# Example 1:
# Input: $s = 'redivider'
# Output: r redivider e edivide d divid i ivi v
# Example 2:
# Input: $s = 'deific'
# Output: d e i ifi f c
# Example 3:
# Input: $s = 'rotors'
# Output: r rotor o oto t s
# Example 4:
# Input: $s = 'challenge'
# Output: c h a l ll e n g
# Example 5:
# Input: $s = 'champion'
# Output: c h a m p i o n
# Example 6:
# Input: $s = 'christmas'
# Output: c h r i s t m a

use strict;
use warnings;
use feature 'say';

my $str = shift || die "Argument string required\n";
my $len = length $str;

my %eertree;
for my $start (0 .. $len - 1) {
    for my $chars (1 .. $len - $start ) {
        my $w = substr($str, $start, $chars);
        $eertree{$w} = $start.$chars if !exists $eertree{$w} && $w eq reverse $w;
    }
}

sub by_position { $eertree{$a} <=> $eertree{$b} };
say join ' ', sort by_position keys %eertree;

__END__

$ ./ch-2.pl rotors
r rotor o oto t s

$ ./ch-2.pl christmas
c h r i s t m a

$ ./ch-2.pl redivider
r redivider e edivide d divid i ivi v
