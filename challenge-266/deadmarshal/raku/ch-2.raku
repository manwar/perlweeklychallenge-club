#!/usr/bin/env raku

sub x-matrix(@mat){
  for 0..@mat.end -> $i {
    for 0..@mat.end -> $j {
      if ($i == $j || $i+$j == @mat.end) {
	return False if @mat[$i][$j] == 0
      }
      elsif (@mat[$i][$j] != 0) {return False}
    }
  }
  True
}

say x-matrix([[1,0,0,2],
	      [0,3,4,0],
	      [0,5,6,0],
	      [7,0,0,1]]);

say x-matrix([[1,2,3],
	      [4,5,6],
	      [7,8,9]]);

say x-matrix([[1,0,2],
	      [0,3,0],
	      [4,0,5]]);
