#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

my $comment = <<'DOC';
You are given 2 strings, $A and $B.

Write a script to find out common base strings in $A and $B.

A substring of a string $S is called base string if repeated concatenation of the substring results in the string.

Example 1:
Input:
    $A = "abcdabcd"
    $B = "abcdabcdabcdabcd"

Output:
    ("abcd", "abcdabcd")
Example 2:
Input:
    $A = "aaa"
    $B = "aa"

Output:
    ("a")
DOC

common_base( "abcdabcd", "abcdabcdabcdabcd" );
common_base( "aaa",      "aa" );

sub common_base ( @words ) {
    my ( $aa, $bb ) = sort { length $a <=> length $b } @words;
    my %output;

    for my $i ( 0 .. length $aa ) {
        for my $j ( 1 .. ( length $aa ) - $i ) {
            my $aaa = $aa;
            my $bbb = $bb;
            my $sub = substr( $aa, $i, $j );
            my $pad = ' ' x $i;
            $aaa =~ s/$sub//gmix;
            $bbb =~ s/$sub//gmix;
            next unless $aaa eq '' && $bbb eq '';
            # say qq{    $pad$sub\t$aaa\t$bbb};
            $output{$sub} = 1 if $aaa eq '' && $bbb eq '';
        }

    }
    say join ', ', keys %output;
}

