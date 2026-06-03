use v6 ;

sub makeChessboard {
   my @chessboard ;
   for (1..8) -> $i {
      if ( $i % 2 == 1 ) {
         @chessboard.push( "BW" x 4 ) ;
      }
      else {
         @chessboard.push( "WB" x 4 ) ;
      }
   }
   return @chessboard ;
}

say "Enter two chess fields separated by blanks!" ;
my $line = $*IN.get ;
my ($first , $second ) = $line.words ;
my @chessboard = makeChessboard( ) ;
say @chessboard[$first.substr( 1 , 1).Int - 1].substr("abcdefgh".index( $first.
      substr( 0 , 1 )) , 1 ) eq @chessboard[$second.substr(1 , 1).Int - 1].substr(
   "abcdefgh".index( $second.substr( 0 , 1)) , 1 ) ;
