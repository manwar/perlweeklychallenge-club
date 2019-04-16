#!/usr/bin/env perl6

use v6;

#| Find words in a file that contain only the given letters
unit sub MAIN(
  Str $file #= file containing list of words
          where { given .IO { .r && ( .l || .f) or die "Cannot read from $_" } },
  *@letters #= list of letters to search for
);

my $letter-bag := @letters.hyper.map(*.lc.comb(/ \w /)).flat.Bag;

my @words = $file.IO.lines.unique.hyper.grep(*.chars > 2)
                 .map: { .lc.comb(/ \w /).Bag => $_ };

@words.hyper.grep(*.key ⊆ $letter-bag)».value.unique(with => *.lc eq *.lc).join(', ').put;
