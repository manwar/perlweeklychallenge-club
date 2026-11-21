#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0,
               :v(:$verbose));

my $prev;
my $best = 0;

for 1 .. $n -> $i
{
  my @digits = $i.comb;

  next if @digits.repeated;

  if defined $prev
  {
    my $jump = $i - $prev;
    if $jump > $best
    {
      $best = $jump;
      say ": $prev -> $i, jump $jump" if $verbose;
    }
  }

  $prev = $i;
}

say $best;