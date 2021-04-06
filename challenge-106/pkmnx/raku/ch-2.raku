#!/usr/bin/env raku

## see usage:
## pk@pkx:~/stuff/.../challenge-106/pkmnx/raku$ ./ch-2.raku 6 55
## 0.1(09)
## pk@pkx:~/stuff/.../challenge-106/pkmnx/raku$ ./ch-2.raku 1 3
## 0.(3)
## pk@pkx:~/stuff/.../challenge-106/pkmnx/raku$ ./ch-2.raku 1 2
## 0.5
## pk@pkx:~/stuff/.../challenge-106/pkmnx/raku$ ./ch-2.raku 5 66
## 0.0(75)
## pk@pkx:~/stuff/.../challenge-106/pkmnx/raku$ ./ch-2.raku 5 1
## 5
## pk@pkx:~/stuff/.../challenge-106/pkmnx/raku$ ./ch-2.raku 5 0
## D must be >= 1.
##   in sub MAIN at ./ch-2.raku line 20

sub MAIN( Int $N, Int $D ) {

  die("D must be >= 1.") if $D < 1;

  divi( $N, $D, {}, [] ).say;

}

sub divi( $N, $D, $sn, $ot ) {

   my ( $cnt, $a, $b ) = ( 0, $N, $D );

   while ( $a >= $b ) {
     $a -= $b;
     $cnt++;
   }

   my $na = $a * 10;
   my $ky = ($a,$b).join(":");
   $ot.push([ $ky, $cnt, $na, $b ]);

   if ( $sn{$ky}:exists ) {
      fin( True, $ky, $ot );
   } else {
      if ( $na > 0 ) {
         $sn{$ky}++;
         divi( $na, $b, $sn, $ot );
      } else {
         fin( False, $ky, $ot );
      }
   }

}

sub fin( $b, $ky, $ot ) {

   my ( $nb, $v, $cnt, $ncnt ) = ( $b, [], 0, 0 );
   
   $ot.map(-> $i {
      $v.push( $i[1] );
      if ( $nb && ($i[0] ~~ $ky) ) {
         $v.push("(");
         $nb = False;
         $cnt++;
      }
      $ncnt++;
   });

   $v.push(")") if $cnt > 0;
   $v[0] = ($v[0],".").join("") if $v.elems > 1;
   $v.join("");

}
