#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( shuffle );
use Text::Wrap;

sub rearrange($word) {
  return $word unless length($word) > 2;
  my @chars = split //, $word; # break word into characters
  my @letters = grep {/\p{L}/} @chars; # only letters
  my $first = shift @letters; # remove the first letter
  my $last  = pop @letters;   # remove the last letter
  @letters = shuffle @letters; # shuffle the remaining letters
  unshift @letters, $first;   # put the first letter back
  push @letters, $last;       # put the last letter back

  # reassemble the word
  $word = '';
  # loop over the char list
  foreach my $i (0 .. $#chars) {
    if ( $chars[$i] =~ /\p{L}/ ) {
      # if it's a letter, pull it's replacement
      # off the @letters array
      $word .= shift @letters;
    }
    else {
      # otherwise, it's punctuation, so
      # leave it alone
      $word .= $chars[$i];
    }
  }

  return $word;
}

sub jumbleLetters($text) {
  my @words = split /\s+/, $text;
  foreach my $word (@words) {
    $word = rearrange($word);
  }
  return join(" ", @words);
}

sub solution($text) {
  $Text::Wrap::columns = 65;
  say 'Input:';
  say wrap('', '', $text);
  my $jumbled = jumbleLetters($text);
  say "\nOutput:";
  say wrap('', '', $jumbled);
  say "";
}

say "Example 1:";
solution(
  "According to research at Cambridge University, it doesn't " .
  "matter in what order the letters in a word are, the only " .
  "important thing is that the first and last letter be at " .
  "the right place. The rest can be a total mess and you can " .
  "still read it without problem.  This is because the human " .
  "mind does not read every letter by itself, but the word as " .
  "a whole."
);

say "\nExample 2:";
solution("Perl Weekly Challenge");

say "\nExample 3:";
solution("’Twas brillig, and the slithy toves
Did gyre and gimble in the wabe:
All mimsy were the borogoves,
And the mome raths outgrabe.");

say "\nExample 4:";
solution("My mother-in-law says I shouldn't've have used
so many parentheticals (but I completely disagree!).");
