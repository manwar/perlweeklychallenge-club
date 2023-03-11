#!/usr/bin/env raku
#`(
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-06
Challenge 207 Keyboard Word ( Raku )
--------------------------------------
)

use v6;

my @rows = ["qwertyuiop", "asdfghjkl", "zxcvbnm"];
my @words = [["Hello Alaska Dad Peace"], ["OMG Bye"]];

sub CheckLetters($tw is copy) {
    my $flag = 0;
    $tw=$tw.lc;
    for 0..2 -> $ndx {
        for 0..$tw.chars-1 -> $c {
            my $z = substr($tw,$c,1);
            (@rows[$ndx].contains($z)) ?? (next) !! ($flag = 1);
         }
        if $flag == 0 { say "\t$tw" };
        $flag = 0;
   }
}

sub GetWords(@wds) {
    my $ln = @wds.elems;
    my @tw = @wds.split(' ');
    for 0..$ln-1 -> $i {
        my $test_word = @tw[$i];
        CheckLetters($test_word);
    }
    say " ";
}

for (@words) -> @w {
    say "Input: \@words = ",@w;
    say "Output: ";
    my @test_words = @w.split(' ');
    GetWords(@test_words);
}

#`(
--------------------------------------
SAMPLE OUTPUT
 raku .\KeyboardWord.rk
Input: @words = [Hello Alaska Dad Peace]
Output:
        alaska
        dad

Input: @words = [OMG Bye]
Output:

--------------------------------------
)
