#!/usr/bin/env raku

# see usage: 
#
#  pk@pkx:~/stuff/raku/perlweeklychallenge-club/challenge-100/pkmnx/raku$ cat input.1 
#  1
#  2,4
#  6,4,9
#  5,1,7,2
#  pk@pkx:~/stuff/raku/perlweeklychallenge-club/challenge-100/pkmnx/raku$ ./ch-2.raku < input.1
#  The minimum path sum from top to bottom: 1 + 2 + 4 + 1 = 8
#  
#  [1]
#  [2] 4
#  6 [4] 9
#  5 [1] 7 2
#

our $cch = [];
sub MAIN() { 
   my ( $mvls, $out, $lsz )  = ( [], [], 0 );
   ## take input
   my $d = lines().map(*.comb(/\d+/));
   ## validate
   for $d { my $nsz = $_.elems; die("bad input!") if $lsz > 0 && $nsz != $lsz + 1; $lsz = $nsz };
   ## run
   f($d,0,0);
   ## display - distinguish lowest val per line in "[]" and display sum
   for (^$d) -> $y {
      my $m = $cch[$y].pairs.min(*.value);
      $out.push( (^$d[$y]).map({ my $v = $d[$y][$_]; $_ == $m.key ??($mvls.push($v) && "[$v]") !!$v }).join(" ") );
   }
   say "The minimum path sum from top to bottom: " ~ $mvls.join(" + ") ~ " = " ~ $mvls.sum ~ "\n";
   say $out.join("\n");
}

sub f ($d, $y, $x)  {
   ! $d[$y][$x].defined && return Nil;
   $cch[$y][$x].defined && return $cch[$y][$x];
   ## recur
   my $ar = (0,1).map({f($d, $y +1, $x +$_)}).grep(*.defined);
   ## set cache elem to min of path from bottom up
   return $cch[$y][$x] = $d[$y][$x] + ( $ar.elems >0 ??$ar.min !!0 );
}
