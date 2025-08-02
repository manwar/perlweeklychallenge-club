#!/usr/bin/env raku
use Test;

grammar Goat-Latin
{
    has @.words;

    token TOP       { [<.vowel> || <.consonant>]* % ' '                                                      }
    token vowel     { :i <[aeiou]>  <.alpha>* { @.words.push: ~$/ ~ "maa" ~ "a" x @.words                  } }
    token consonant { :i <-[aeiou]> <.alpha>* { @.words.push: ~$/.comb.rotate.join ~ "maa" ~ "a" x @.words } }
}

is Goat-Latin.parse("I love Perl").words,               "Imaa ovelmaaa erlPmaaaa";
is Goat-Latin.parse("Perl and Raku are friends").words, "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"; 
is Goat-Latin.parse("The Weekly Challenge").words,      "heTmaa eeklyWmaaa hallengeCmaaaa";
