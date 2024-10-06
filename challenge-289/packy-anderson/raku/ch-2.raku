#!/usr/bin/env raku
use v6;

use Text::Wrap;

sub rearrange($word is copy) {
  return $word unless $word.chars > 2;
  my @chars = $word.comb; # break word into characters
  my @letters = @chars.grep(/ <:L> /); # only letters
  my $first = @letters.shift; # remove the first letter
  my $last  = @letters.pop;   # remove the last letter
  @letters .= pick(*);        # shuffle the remaining letters
  @letters.unshift($first);   # put the first letter back
  @letters.push($last);       # put the last letter back

  # reassemble the word
  $word = '';
  # loop over the char list
  for 0 .. @chars.end -> $i {
    if ( @chars[$i] ~~ / <:L> / ) {
      # if it's a letter, pull it's replacement
      # off the @letters array
      $word ~= @letters.shift;
    }
    else {
      # otherwise, it's punctuation, so
      # leave it alone
      $word ~= @chars[$i];
    }
  }

  return $word;
}

sub jumbleLetters($text) {
  my @words = $text.comb(/\S+/);
  for @words <-> $word {
    $word = rearrange($word);
  }
  return @words.join(" ");
}

sub solution($text) {
  say 'Input:';
  say wrap-text($text, :width(65));
  my $jumbled = jumbleLetters($text);
  say "\nOutput:";
  say wrap-text($jumbled, :width(65));
  say "";
}

say "Example 1:";
solution(
  "According to research at Cambridge University, it doesn't " ~
  "matter in what order the letters in a word are, the only " ~
  "important thing is that the first and last letter be at " ~
  "the right place. The rest can be a total mess and you can " ~
  "still read it without problem.  This is because the human " ~
  "mind does not read every letter by itself, but the word as " ~
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
