use v6 ;

sub findPossibilities( $timeterm) {
   my $possibilities = 1 ;
   given $timeterm {
      when /^ '?' '?'/ { $possibilities *= 24 }
      when /^ '?' (\d)/ {
         my $number = +$0 ;
         if ( $number < 4 ) {
            $possibilities *= 3 ;
         }
         else {
            $possibilities *= 2 ;
         }
      }
      when /^ (\d) '?'/ {
         my $number = +$0 ;
         if ( $number < 2 ) {
            $possibilities *= 10 ;
         }
         else {
            $possibilities *= 4 ;
         }
      }
   }
   if ( $timeterm ~~ /'?' . $/ ) {
      $possibilities *= 6 ;
   }
   if ( $timeterm ~~ /'?' $/ ) {
      $possibilities *= 10 ;
   }
   return $possibilities ;
}

say findPossibilities( "?2:34" ) ;
say findPossibilities( "?4:?0" ) ;
say findPossibilities( "??:??" ) ;
say findPossibilities( "?3:45" ) ;
say findPossibilities( "2?:15" ) ;

         

