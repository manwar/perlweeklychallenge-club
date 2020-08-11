#! /usr/bin/env raku

subset SteppingLimit of Int where 100 <= * <= 999;

unit sub MAIN (SteppingLimit $from,
               SteppingLimit $to where $to > $from,
	       :$verbose);

say ": Candidates: { ($from.Int .. $to.Int).list }" if $verbose;

my $a = $from.substr(0,1).Int;
my $b = $to.substr(0,1).Int;

my $stepping := gather
{
  for $a .. $b -> $first-digit
  {
    for $first-digit -1, $first-digit + 1 -> $second-digit
    {
      next unless -1 < $second-digit < 10;
      
      for $second-digit -1, $second-digit + 1 -> $third-digit
      {
        next unless -1 < $third-digit < 10;
	my $current = "$first-digit$second-digit$third-digit".Int;
	take $current if $from <= $current <= $to;
      }
    }
  }
}

say $stepping.join(", ");
