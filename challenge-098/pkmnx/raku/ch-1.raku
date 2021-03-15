#!/usr/bin/env raku


sub MAIN() {

   my $fi = "input.txt";
   readN( $fi, 4).say;
   readN( $fi, 4).say;
   readN( $fi, 4).say;
   readN( $fi, 0);
   readN( $fi, 4).say;
   readN( $fi, 4).say;
 
}

sub readN($FILE, $number) {
   if ( $number == 0 ) {
      GLOBAL::<$FILE> = 0 if defined GLOBAL::<$FILE>;
   } else {
      GLOBAL::<$FILE> = 0 if ! defined GLOBAL::<$FILE>;
      my $ch = "";
      if $FILE.IO.e {
         given $FILE.IO.open {
            .seek: GLOBAL::<$FILE>, SeekFromBeginning;
            $ch = .readchars: $number;
            .close;
         }
      } else {
         die ("$FILE does not exist.")
      }
      $ch.chomp;
      GLOBAL::<$FILE> += $ch.chars;
      $ch;
   }
}
