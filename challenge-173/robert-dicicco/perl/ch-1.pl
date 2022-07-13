#!perl.exe

use strict;
use warnings;

# AUTHOR: Robert DiCicco
# DATE: 2022-07-12
# Challenge 173 Esthetic Number ( Perl )


sub is_esthetic {

  my $v = shift;
  my @arr = split(//,$v);               # split into digits
  my $i = 0;
  my $prev = $arr[0];

  $i++;

  while ($i <= $#arr) {
    if(abs($arr[$i] - $prev) == 1 ){    # check that absolute value of diff between digits = 1
      $prev = $arr[$i];
      $i++;
    } else {
      return -1;                        # if not, return -1
    }
  }

  return 1;                             # return 1, is Esthetic
}

for my $e (100 .. 5000 ){               # check all ints 100 to 5000

  my $retval = is_esthetic($e);

  if($retval == 1){

    print("$e ");

  }

}

print("\n");
