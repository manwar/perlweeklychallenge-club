#!/usr/bin/perl
# Perl Weekly Challenge #074 Task 2 FNR character
# task statement:
# You are given a string $S.
# Write a script to print the series of
#  first non-repeating character 
# (left -> right) for the given string. 
#  Print # if none found.
# Usage: ch-2.pl [string]

use strict;
use warnings;
#use Test::More tests => 5;

sub fnr {
    my @uniquestack;
    my %charcount;
    my $ans = "";
    my @characters = split //, $_[0];
    for my $char (@characters) {
        if (!exists $charcount{$char} ) {
            push @uniquestack , $char;
            $charcount{$char} = 1;
            $ans .= $char;
        } 
        else {
            $charcount{$char}++;
            @uniquestack = grep { $charcount{$_} == 1 } @uniquestack;
            $ans .= (scalar @uniquestack != 0) ? $uniquestack[-1]  : "#";
        }
    }
    return $ans;

}

print fnr("$ARGV[0]");

=pod
is_deeply( fnr("ababc") , "abb#c", "example1 provided");
is_deeply( fnr("xyzzyx") , "xyzyx#", "example2 provided");
is_deeply( fnr("abcdef") , "abcdef", "trival");
is_deeply( fnr("aaabbb") , "a##b##", "repeats");
is_deeply( fnr(
  "thequickbrownfoxjumpsoverthelazydog") , 
  "thequickbrownffxjjmpssvvvvvvlazyddg",
  "long sentence"
);
=cut
