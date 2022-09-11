#!/usr/bin/env raku

grammar Text {
  token TOP { <sentence> [\s* <sentence>]* \n? }
  token sentence { <word> [<separation>+ <word>]* <sterminal> }
  token separation { [\s+ | '-'] }
  token postfix-punctuation { <[,:]> }
  token word { <[\w'-]>+ <postfix-punctuation>? }
  token sterminal { '...' | '.' | '?' | '!' }
}

class TextActions {
  method TOP($/) { make $<sentence>>>.made.join: ' ' }
  method sentence($/) {
    my @ordered = $<word>>>.made.collate;
    my @sparts = @ordered.first, slip flat $<separation>>>.made Z @ordered.skip;
    make ([~] @sparts) ~ $<sterminal>.made
  }
  method sterminal($/) { make $/.Str }
  method separation($/) { make $/.Str }
  method word($/) { make $/.Str }
}

my $input = q:to/END/;
All he could think about was how it would all end. There was
    still a bit of uncertainty in the equation, but the basics
    were there for anyone to see. No matter how much he tried to
    see the positive, it wasn't anywhere to be seen. The end was
    coming and it wasn't going to be pretty.
END
    
say Text.parse($input, actions => TextActions).made;