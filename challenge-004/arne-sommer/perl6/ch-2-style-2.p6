#! /usr/bin/env perl6

unit sub MAIN ($word-file where $word-file.IO.r, *@letters where @letters.elems >= 1);

my %words is SetHash;

%words{$_.lc} = True for $word-file.IO.lines();

my $max-length = %words.keys>>.chars.max;

my %seen;

for @letters.combinations: 1 .. $max-length -> $candidate
{
  my $word = $candidate.sort.join;
  next if %seen{$word};
  %seen{$word} = True;
  say "seen $word";
  for $word.comb.permutations.map(*.join).sort.unique -> $possible
  {
    say $possible if %words{$possible};
  }
}
