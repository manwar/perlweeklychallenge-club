#! /usr/bin/env raku

unit sub MAIN (*@N where all(@N) ~~ Numeric, :v(:$verbose));

my $sum   = 0;
my $count = 0;

my @result;

for @N -> $current
{
  $sum += $current;

  my $avg = $sum / ++$count;
  @result.push: $avg;

  say "Average of first { $count == 1 ?? "number" !! "$count numbers" } ({ @N[^$count].join("+")  })/$count = $avg" if $verbose;

}

say @result.join(", ");
