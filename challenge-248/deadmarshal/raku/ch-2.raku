#!/usr/bin/env raku

sub submatrix-sum(@m)
{
  my @ret;
  for 0..@m.elems-2 -> $i {
    for 0..@m[0].elems-2 -> $j {
      @ret[$i;$j] = @m[$i;$j] + @m[$i;$j+1] +
		     @m[$i+1;$j] + @m[$i+1;$j+1];
    }
  }
  @ret
}

say submatrix-sum([[1,2,3,4],[5,6,7,8],[9,10,11,12]]);
say submatrix-sum([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]);

