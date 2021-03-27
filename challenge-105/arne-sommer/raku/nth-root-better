#! /usr/bin/env raku

unit sub MAIN (:$N, :$k, :i($iterations) = 10, :b($best), :v($verbose));

my $start = 1;

$start++ while ($start + 1) ** $N < $k;

say ": Start: $start" if $verbose;

my $seq := gather
{
  take $start;
  my $index = 0;

  loop
  {
    take (1/$N) * ( ($N - 1) * $seq[$index] + ($k / $seq[$index] ** ($N - 1) ));

    $index++;
  }
} 

if $best
{
  my $index = 0;
  my $current = $seq[$index++];
  $current = $seq[$index++] while $current != $seq[$index];
  
  say ": ", $seq[0..$index].join(" | ") if $verbose;

  say $seq[$index];

}
else
{
  say ": ", $seq[^$iterations].join(" | ") if $verbose;

  say $seq[$iterations -1];
}