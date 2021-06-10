#!/usr/bin/env perl6
#
#
#       get-in-line.raku
#
#       Ordered Letters
#         Submitted by: E. Choroba
# 
#         Given a word, you can sort its letters alphabetically (case
#         insensitive). For example, “beekeeper” becomes “beeeeekpr” and
#         “dictionary” becomes “acdiinorty”.
# 
#         Write a script to find the longest English words that don’t change
#         when their letters are sorted.
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

our $dict = '/usr/share/dict/words';

my %sorted_words = 
    $dict.IO.lines
            .map({.lc})
            .grep({is_sorted($_)}) 
            .map({ $_ => $_.chars });
            
my $longest = %sorted_words.values.max;

say "longest word length $longest\n";
.say for %sorted_words.keys.grep({%sorted_words{$_} == $longest});


sub is_sorted ($word) {
    return False if $word.chars < 3;
    for ($word.comb).rotor(2 => -1) -> ($a, $b) {
        return False if $a cmp $b == 1
    }
    return True
}

