#!/usr/bin/env raku
=begin comment
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-12
Challenge 221 Task 1 Good Strings ( Raku )
-------------------------------------
=end comment

my $total_score = 0;

my @words = (["cat", "bt", "hat", "tree"], ["hello", "world", "challenge"]);
my @chlist = ("atach","welldonehopper");
my $cnt = 0;
for (@words) -> @word {
    say "Input: \@words = ",@word;
    my $chars = @chlist[$cnt];
    $total_score = 0;
    for (@word) -> $w {
        my $ln = $w.chars;
        my $score = 0;
        loop (my $cnt = 0; $cnt < $ln; $cnt++){
            my $tst = substr($w,$cnt,1);
            if $chars.contains($tst) {
                $score++;
            } else {
                last;
            }
        }
        if ($score == $ln) {
            say $w;
            $total_score += $score;
            $score = 0;
        }
    }
    say "\tTotal: ", $total_score;
     say "";
     $cnt++;
}

=begin comment
-------------------------------------
SAMPLE OUTPUT
raku .\GoodStrings.rk

Input: @words = [cat bt hat tree]
cat
hat
        Total: 6

Input: @words = [hello world challenge]
hello
world
        Total: 10
-------------------------------------
=end comment


