#!/usr/bin/env raku
use v6;

my regex vowels     { <[aeiou]> }
my regex consonants { <[a..z] - [aeiou]> }

my regex isAlternating {
  ^[ <vowels>?    [ <consonants> <vowels> ]+ |
     <consonants>?[ <vowels> <consonants> ]+ ]$
}

sub altSubstrings($s) {
  my $substrings = BagHash.new;
  for 0 .. $s.chars -> $i  {
    for (2 .. $s.chars - $i).reverse -> $j {
      my $sub = $s.substr($i, $j);
      $substrings.add($sub) if $sub ~~ /<isAlternating>/;
    }
  }
  $substrings;
}

sub lcs(@arr) {
  my $bag = altSubstrings(shift @arr);
  $bag ∩= altSubstrings($_) for @arr;
  my $longest = $bag.keys.sort(*.chars).reverse.first;
  $bag.keys.grep( *.chars == $longest.chars ).sort;
}

sub quote_join(@list) {
  @list.map({ qq/"$_"/ }).join: ', ';
}

sub solution(@arr) {
  say "Input: \@arr = ({quote_join(@arr)})";
  say "Output: ({quote_join(lcs(@arr))})";
}

say "Example 1:";
solution(["relocate", "delocate", "allocate"]);

say "\nExample 2:";
solution(["apple", "banana", "cherry"]);

say "\nExample 3:";
solution(["navigate", "cavity", "gravity"]);

say "\nExample 4:";
solution(["pedalgia", "pedalboard", "pedantic"]);

say "\nExample 5:";
solution(["schoolmaster", "schoolhouse", "schooling"]);

