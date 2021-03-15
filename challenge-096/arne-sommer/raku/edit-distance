#! /usr/bin/env raku

sub MAIN ($S1, $S2)
{
  say wagner-fischer($S1, $S2);
}

sub wagner-fischer (Str $s, Str $t)
{
  my $m = $s.chars;
  my $n = $t.chars;

  my @s = " $s".comb;
  my @t = " $t".comb;

  my @d;

  for 1 .. $m -> $i
  {
    @d[$i][0] = $i;
    
    for 1 .. $n -> $j
    {
      @d[$i][$j] = 0;
    }
  }  

  for 0 .. $n -> $j
  {
    @d[0][$j] = $j;
  }

  for 1 .. $m -> $i
  {
    for 1 .. $n -> $j
    {
      my $cost = @s[$i] eq @t[$j]
        ?? 0
	!! 1;

      @d[$i][$j] = min( @d[$i-1][$j] +1,        # Deletion
                        @d[$i][$j-1] +1,        # Insertion
                        @d[$i-1][$j-1] +$cost); # Deletion
    }
  }

  return @d[$m][$n];
}
