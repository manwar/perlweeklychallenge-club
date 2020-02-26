#! /usr/bin/env raku

unit sub MAIN ($string is copy = "The quick brown fox jumps over the lazy dog", :$verbose);

$string ~~ tr/" "//;

say ": { $string.lc }" if $verbose;

my @a = $string.lc.comb;

for 0 .. 7 -> $word
{
  my $index = $word;
  loop
  {
    @a[$index]:exists
     ?? print  @a[$index]
     !! ( print " "; last);

   $index += 8;
  }
}

say "";
