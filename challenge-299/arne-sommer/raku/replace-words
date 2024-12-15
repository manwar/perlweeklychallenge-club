#! /usr/bin/env raku

unit sub MAIN ($sentence where $sentence.chars > 0,
               *@words where @words.elems > 0,
	       :v(:$verbose));

my @output;

WORD:
for $sentence.words -> $word
{
  for @words -> $replace
  {
    if $word.starts-with($replace)
    {
      @output.push: $replace;
      say ": Replace '$word' with '$replace'" if $verbose;
      next WORD;
    }  
  }
  @output.push: $word;
}

say @output.join(" ");
