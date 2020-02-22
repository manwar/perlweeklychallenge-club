#! /usr/bin/env raku

for 0..2 -> $y2
{
  for 0..9 -> $y3
  {
    for 0..1 -> $y4
    {
      for 0..1 -> $m1
      {
        for 0..9 -> $m2
	{
          for 0..2 -> $d1
	  {
	    next unless $m1 == $y4 && $m2 == $y3 && $d1 == $y2;
	    next if $m1 == 0 == $m2;
    	    next if $m1 == 1 && $m2 > 2;
  
	    say $m1 ~ $m2 ~ $d1 ~ '22' ~ $y2 ~ $y3 ~ $y4;
	  }
	}
      }
    }
  }
}
