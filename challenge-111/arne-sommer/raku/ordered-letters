#! /usr/bin/env raku

unit sub MAIN (:d(:$dictionary) where $dictionary.IO.r = "/usr/share/dict/british-english", :a($all));

my @dict = $dictionary.IO.lines.grep(* !~~ /\W/).map( *.lc ).sort({ $^b.chars <=> $^a.chars });

my $found = 0;

for @dict -> $word
{
  last if !$all && $word.chars < $found;
  
  my $sorted = $word.comb.sort.join;
  
  if $word eq $sorted
  {
    say $word;
    $found = $word.chars;
  }
}
