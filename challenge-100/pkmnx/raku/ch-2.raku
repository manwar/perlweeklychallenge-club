#!/usr/bin/env raku

# see usage: 
#
#  pk@pkx:~/stuff/raku/perlweeklychallenge-club/challenge-100/pkmnx/raku$ cat input.1 
#  1
#  2,4
#  6,4,9
#  5,1,7,2
#  pk@pkx:~/stuff/raku/perlweeklychallenge-club/challenge-100/pkmnx/raku$ ./ch-2.raku < input.1
#  The minimum path sum from top to bottom: 1 +2 +4 +1 = 8
#
#      [1]
#     [2] 4
#    6 [4] 9
#   5 [1] 7 2
#

our $cch = [];
sub MAIN() { 
   my ( $mvls, $dm, $out, $lsz, $y, $x )  = ( [], [], [], 0, 0, 0 );
   ## take input
   my $d = lines().map(*.comb(/\d+/));
   ## validate
   for $d { my $nsz = $_.elems; die("bad input!") if $lsz > 0 && $nsz != $lsz + 1; $lsz = $nsz };
   ## run
   f($d,0,0);

   ## display - find path from cache
   while ( $y < $d.elems ) {
      my ($min, $mini) = (Inf, 0);
      (0,1).map({
         if ( $cch[$y][$x +$_].defined ) {
            my $v = $cch[$y][$x +$_]; if ( $v < $min ) { $min = $v; $mini = $_ }
         }
      });
      $x += $mini;
      $dm.push( $x );
      $mvls.push( $d[$y][$x] );
      $y++;
   }
   ## center printf formatting & highlight each in "[]" and display sum
   my $mxl = (^$d).map({ my $l = $d[$_]; my $chs = gather { for (^$l) { take $l[$_].chars +1 } }; $chs.sum }).max +4;
   for (^$d) -> $y {
      $out.push( (^$d[$y]).map({ my $v = $d[$y][$_]; $_ == $dm[$y] ??"[$v]" !!$v }).join(" ") );
   }
   say "The minimum path sum from top to bottom: " ~ $mvls.join(" +") ~ " = " ~ $mvls.sum ~ "\n";
   for (^$out) { printf("%*s\n", ($mxl - $out[$_].chars)/2 +$out[$_].chars, $out[$_]) }
}

sub f ($d, $y, $x) {
   ! $d[$y][$x].defined && return Nil;
   $cch[$y][$x].defined && return $cch[$y][$x]; ## no need to recalc same path
   ## recur
   my $ar = (0,1).map({f($d, $y +1, $x +$_)}).grep(*.defined);
   ## set cache elem to min of path from bottom up
   return $cch[$y][$x] = $d[$y][$x] +( $ar.elems >0 ??$ar.min !!0 );
}
