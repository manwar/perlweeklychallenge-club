#! /usr/bin/env raku

unit sub MAIN (UInt $num,
               UInt $k where $k > 0 && $k <= min($num.chars, 9),
	       :v(:$verbose));

my $matches = 0;

for 0 .. $num.chars - $k -> $start
{
  my $candidate = $num.substr($start, $k);
  my $match     = $num %% $candidate;

  $matches++ if $match;

  say ": candidate $candidate [start:$start stop:{ $start + $k -1 }] { $match ?? "- $num is divisible by { $candidate.Int }" !! ""}" if $verbose;

}

say $matches;
