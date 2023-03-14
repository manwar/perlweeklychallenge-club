#!/usr/bin/env perl
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-06
Challenge 207 Keyboard Word ( Perl )
--------------------------------------
=cut
use strict;
use warnings;
use feature 'say';

my @rows = ("qwertyuiop", "asdfghjkl", "zxcvbnm");
my @words = ("Hello Alaska Dad Peace", "OMG Bye");

sub do_nothing {
    return;
}

sub CheckLetters {
    my $w = shift;
    $w = lc($w);
    my $flag = 0;
    my $ln = length($w);
    for my $ndx (0..2) {
        for my $c (0..$ln-1) {
            my $z = substr($w,$c,1);
            if($rows[$ndx] =~ /$z/) {
                do_nothing;
            } else {
                $flag = 1;
            }
         }
        if ($flag == 0) {
                say "\t$w";
            }
            $flag = 0;
    }
}

for my $wds (@words) {
    say "Input: \@array = [$wds]";
    say "Output: ";
    my @split_words = split(" ",$wds);
    foreach (@split_words) {
        CheckLetters($_);
    }
    say " ";
}

=begin comment
--------------------------------------
SAMPLE OUTPUT
perl .\KeyboardWord.pl
Input: @array = [Hello Alaska Dad Peace]
Output:
        alaska
        dad

Input: @array = [OMG Bye]
Output:

--------------------------------------
=cut


