#!/usr/bin/env perl6

use v6;

#| Find anagrams of a word in given file
unit sub MAIN(
  Str $file #= file containing list of words
          where { given .IO { .r && ( .l || .f) or die "Cannot read from $_" } },
  $word #= word to find anagrams of
);

my $word-bag := $word.lc.comb(/ \w /).Bag;

my @words = $file.IO.lines.unique.hyper.grep(*.chars > 2)
                 .map: { .lc.comb(/ \w /).Bag => $_ };

@words.race.grep(*.key === $word-bag)».value.unique(with => *.lc eq *.lc).join(', ').put;
