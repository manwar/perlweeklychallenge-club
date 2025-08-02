#!/usr/bin/env raku
use v6;

sub brokenKeys($sentence, @keys) {
  my @words = $sentence.comb(/\S+/);
  my $regex = '<[' ~ @keys.join ~ ']>';
  return ( ( @words.grep({! /:i <$regex>/ }) ).elems )
}

sub solution($sentence, @keys) {
  say 'Input: $sentence = "' ~ $sentence 
    ~ '", @keys = (\'' ~ @keys.join("', '") ~ '\')';
  say 'Output: ' ~ brokenKeys($sentence, @keys);
}

say "Example 1:";
solution("Perl Weekly Challenge", ['l', 'a']);

say "\nExample 2:";
solution("Perl and Raku", ['a']);

say "\nExample 3:";
solution("Well done Team PWC", ['l', 'o']);

say "\nExample 4:";
solution("The joys of polyglottism", ['T']);
