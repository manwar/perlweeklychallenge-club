#! /usr/bin/env perl6

my @letters;
my %words is SetHash;

for lines() -> $word-or-character
{
  if $word-or-character.chars == 1
  {
    @letters.push($word-or-character.lc);
  }
  else
  {
    %words{$word-or-character.lc} = True;
  }
}

my $max-length = %words.keys>>.chars.max;

my %seen;

for @letters.combinations: 2 .. $max-length -> $candidate
{
  my $word = $candidate.sort.join;
  next if %seen{$word};
  %seen{$word} = True;
  
  for $word.comb.permutations.map(*.join).sort.unique -> $possible
  {
    say $possible if %words{$possible};
  }
}