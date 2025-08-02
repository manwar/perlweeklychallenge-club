#!/usr/bin/env perl
use v5.40;

sub brokenKeys($sentence, @keys) {
  my @words = split /\s+/, $sentence;
  my $regex = '[' . join('', @keys) . ']';
  return ( scalar( grep {! /$regex/i } @words) );
}

sub solution($sentence, $keys) {
  say 'Input: $sentence = "' . $sentence 
    . '", @keys = (\'' . join("', '", @$keys) . '\')';
  say 'Output: ' . brokenKeys($sentence, @$keys);
}

say "Example 1:";
solution("Perl Weekly Challenge", ['l', 'a']);

say "\nExample 2:";
solution("Perl and Raku", ['a']);

say "\nExample 3:";
solution("Well done Team PWC", ['l', 'o']);

say "\nExample 4:";
solution("The joys of polyglottism", ['T']);
