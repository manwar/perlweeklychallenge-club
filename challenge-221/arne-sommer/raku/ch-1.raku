#! /usr/bin/env raku

unit sub MAIN ($chars, *@words where @words.elems > 0, :s(:$single-use), :v(:$verbose));

my $chars-bag = $chars.comb.Bag;
my @matches;

for @words -> $word
{
  my $word-bag = $word.comb.Bag;

  if $word-bag (<=) $chars-bag
  {
    @matches.push: $word;
    $chars-bag (-)= $word-bag if $single-use;

    say ": Good word: $word" if $verbose && !$single-use;
    say ": Good word: $word (chars left: { $chars-bag.raku })" if $verbose && $single-use;
  }
  elsif $verbose
  {
    say ": Non-good word: $word";
  }
}

say ": Matches: @matches[]" if $verbose;

say @matches>>.chars.sum;
