#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0, Int $D where $D.chars == 1, :v($verbose));

my @candidates = (1 .. $N).grep( * ~~ /$D/);

say ": Candidates { @candidates.join(', ') }" if $verbose;

for @candidates.combinations(1..*) -> @comb
{
  say ": Considering { @comb.join(' + ') }" if $verbose;
  if @comb.sum == $N
  {
    say 1;
    exit;
  }
}

say 0;