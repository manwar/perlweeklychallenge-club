#!/usr/bin/env raku

use v6;

sub charFrequency(Str $word) {
  my %freq;
  for $word.split('', :skip-empty) -> $c {
    %freq{$c}++;
  }
  return %freq;
}

sub commonCharacters(*@words where ($_.all ~~ Str)) {
  my @freq = @words.map({ charFrequency($_) });
  # grab the character frequency map for the first word
  my $first = shift @freq;
  # now check the characters in the first word against
  # the characters in all the subsequent words
  for @freq -> $subsequent {
    for $first.keys() -> $c {
      if ($subsequent{$c}:!exists) {
        # this character isn't in subsequent words,
        # so let's remove it from the frequency map
        # of the first word
        $first{$c}:delete;
      }
      else {
        # the character IS in subsequent words,
        # so let's set the frequency count to be
        # the minimum count found in those words
        $first{$c} = min($first{$c}, $subsequent{$c});
      }
    }
  }

  # now we generate a list of characters in the order they
  # appear in the first word
  my @output;
  # once again, loop over the characters in the first word
  for @words[0].split('', :skip-empty) -> $c  {
    next unless $first{$c}:exists;
    if ($first{$c} > 1) {
      # there's more than one occurence, so let's decrement
      # the count for the next time through the loop
      $first{$c}--;
    }
    else {
      # there is only one occurence left, so remove the
      # character
      $first{$c}:delete;
    }
    push @output, $c;
  }
  return @output;
}

sub solution {
  my @words = @_;
  say 'Input: @words = ("' ~ @words.join('", "') ~ '")';
  my @output = commonCharacters(@words);
  say 'Output: ("' ~ @output.join('", "') ~ '")';
}

say "Example 1:";
solution("java", "javascript", "julia");

say "\nExample 2:";
solution("bella", "label", "roller");

say "\nExample 3:";
solution("cool", "lock", "cook");