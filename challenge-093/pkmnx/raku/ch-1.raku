#!/usr/bin/env raku

# see usage:
#
#  pk@pkx:~/Downloads/raku/perlweeklychallenge-club/challenge-093/pkmnx/raku$ time echo "(1,1), (2,2), (3,1), (1,3), (5,3)" | ./ch-1.raku  
#  Input: (1, 1), (1, 3), (2, 2), (3, 1), (5, 3)
#  Output: 3
#  (1, 3), (2, 2), (3, 1)
#  
#  real    0m0.362s
#  user    0m0.535s
#  sys     0m0.025s

sub MAIN() {

   my $d = getData();
   my $h = {}[];

   for ( ^$d.elems X ^$d.elems ) -> ($i, $j) {
      next if $i == $j;
      my ($y,     $x) = $d[$i];
      my ($dy,   $dx) = $d[$j];
      my ($dfy, $dfx) = ($dy - $y, $dx - $x);  ## slope
      my $nm = ($dfy, $dfx).join(":");
      $h{$nm}.push([ [$y, $x], [$dy, $dx] ]);
   }

   my $cnt = 0;
   my $pth = {};
   for $h.keys -> $k {
      my $v = $h{$k};
      next if $v.elems < 2;
      $cnt++;
      my $ar = [];
      for (^$v.elems) -> $i {
         my ($hd, $tl) = $v[$i];
         if ( $ar.elems > 1 ) {
            $ar.push($tl) if $hd[0] == $ar.tail[0] and $hd[1] == $ar.tail[1];
         } else {
            $ar.push($hd);
            $ar.push($tl);
         }
      }
      $pth{ $ar.elems }.push($ar);
   }

   if ( $cnt > 0 ) {

      my $fmt = -> $k { $k.map({ "(" ~ $_.join(", ") ~ ")" }).join(", ") };

      my $in = $fmt($d);
      "Input: $in".say;

      my $res = $pth{ $pth.keys.max }[0];
      my $sz = $res.elems;

      "Output: $sz".say;
      $fmt($res).say;

   } else {
      "no result longer than a single point!".say;
   }

}

sub getData() {

   my $cnt = 0;
   my $d = [];

   for lines() -> $l {
      for (  $l ~~ m:g/ ('-'*\d+) \, ('-'*\d+) / ) -> ($y, $x) {
         $d.push( [$y +0, $x  +0] );
         $cnt++;
      }
   }
 
   die ("not enough input!") if $cnt < 2; 

   $d = $d.sort({ $^a[0] <=> $^b[0] or $^a[1] <=> $^b[1] });

   return $d;
}
