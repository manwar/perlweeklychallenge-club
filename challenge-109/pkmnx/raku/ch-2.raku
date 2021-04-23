#!/usr/bin/env raku

# See usage:
# pk@pkx:~/stuff/.../challenge-109/pkmnx/raku$ time ./ch-2.raku 1 2 3 5 4 6 7
# 3 + 7 == 7 + 2 + 1 == 1 + 5 + 4 == 4 + 6
# 5 + 6 == 6 + 2 + 3 == 3 + 1 + 7 == 7 + 4
# 4 + 5 == 5 + 3 + 1 == 1 + 6 + 2 == 2 + 7
# 4 + 7 == 7 + 1 + 3 == 3 + 2 + 6 == 6 + 5
# 6 + 4 == 4 + 1 + 5 == 5 + 2 + 3 == 3 + 7
# 6 + 4 == 4 + 5 + 1 == 1 + 2 + 7 == 7 + 3
# 7 + 2 == 2 + 6 + 1 == 1 + 3 + 5 == 5 + 4
# 7 + 3 == 3 + 2 + 5 == 5 + 1 + 4 == 4 + 6
# 
# real    0m0.337s

sub MAIN( *@N where @N.elems == 7 && @N.all ~~ Numeric ) {

  @N.permutations.grep({ val(|$_) }).map({ disp(|$_) }).join("\n").say;

}
     
sub val ( $a, $b, $c, $d, $e, $f, $g ) { 
  $a + $b == $b + $c + $d == $d + $e + $f == $f + $g;
}
sub disp ( $a, $b, $c, $d, $e, $f, $g ) {
  "$a + $b == $b + $c + $d == $d + $e + $f == $f + $g";
} 
