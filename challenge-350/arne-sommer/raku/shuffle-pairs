#! /usr/bin/env raku

unit sub MAIN (UInt :f(:$from),
               UInt :t(:$to) where $to >= $from,
	       UInt :c(:$count),
	            :v(:$verbose));

my $good = 0;

for $from .. $to -> $current
{
  my $canonical = $current.comb.sort.join;
  my $length    = $current.chars;
  my $shuffle   = 0;
  my @verbose;
  
  for 2 .. Inf -> $multiplier
  {
    my $new = $current * $multiplier;
    last if $new.chars > $length;
    my $canon = $new.comb.sort.join;

    if $canonical eq $canon
    {
      $shuffle++;
      @verbose.push: "$new (x $multiplier)";
      if $shuffle == $count
      {
        say ": $current -> { @verbose.join(", ") } (count $shuffle)" if $verbose;
        $good++;
	last;
      }
    }
  }
}

say $good;