#!/usr/bin/env raku

use LibCurl::HTTP :subs; # Imports jget

sub get-english-words {
  my %words = jget('https://raw.githubusercontent.com/dwyl/english-words/master/words_dictionary.json');
  %words.keys;
}

sub challenge(Int $threshold) {
  my @words = get-english-words;
  my @matching-words = gather for @words.race -> $word {
    my @chars = $word.comb;
    if @chars.elems >= $threshold && @chars.sort.join eq $word {
      take $word;
    }
  }
  @matching-words.sort;
}

multi sub MAIN(Int $threshold = 7) {
  for challenge($threshold) -> $word {
    say $word;
  }
}

multi sub MAIN(Bool :$test) {
  use Test;

  my @tests = (
    (7, ('adelops', 'aegilops', 'alloquy', 'beefily', 'begorry', 'belloot', 'billowy', 'deglory', 'egilops')),
    (8, ('aegilops',))
  );

  for @tests -> ($threshold, @expected) {
    is(challenge($threshold), @expected);
  }

  done-testing;
}
