#! /usr/bin/env raku

unit sub MAIN
(
  :d(:$dictionary) where $dictionary.IO.r = 'dictionary.txt',
  :a(:$abecedarian),
  :o(:$one-new),
  :s(:$stop-start)
);

my @dict = $abecedarian
 ?? $dictionary.IO.lines.grep({ $_ eq $_.comb.sort.join })
 !! $dictionary.IO.lines;
 
my @sentence;
my %letters;

while %letters.keys.elems != 26
{
  my $word = @dict.pick;

  if $one-new && $stop-start && @sentence.elems
  {
    $word = @dict.pick until ($word.comb (-) %letters.keys).elems == 1 && @sentence[*-1].substr(@sentence[*-1].chars -1) eq $word.substr(0,1);
  }
  elsif $one-new
  {
    $word = @dict.pick until ($word.comb (-) %letters.keys).elems == 1;
  }
  elsif $stop-start && @sentence.elems
  {
    $word = @dict.pick until @sentence[*-1].substr(@sentence[*-1].chars -1) eq $word.substr(0,1);
  }

  @sentence.push: $word;

  $word.comb.map({ %letters{$_} = True });
}

say @sentence.join(" ");
