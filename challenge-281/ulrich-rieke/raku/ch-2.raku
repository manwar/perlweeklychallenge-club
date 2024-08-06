use v6 ;

#the basic idea is : find all possible target fields for a given source field!
#then, for every target field found , again create all new target fields until
#the initial target field is in it

sub findTargets( @allFields  , $start ) {
   my $cols = "abcdefgh" ;
   my $rows = "12345678" ;
   my @targets = @allFields.grep( { abs($cols.index( $start.substr( 0 , 1 )) - 
    $cols.index($_.substr( 0 , 1))) == 1 && abs( $rows.index( $start.substr(1 , 1 )) -
    $rows.index( $_.substr( 1 , 1 ) )) == 2 || ( abs( $cols.index( 
	  $start.substr( 0 , 1 )) - $cols.index( $_.substr( 0 , 1 ))) == 2 &&
    (abs( $rows.index( $start.substr( 1 , 1 ) ) - $rows.index( $_.substr( 1 , 1 ))) 
     == 1 ) ) } ) ;
   return @targets ;
}

say "Enter a start and a target chess field!" ;
my $line = $*IN.get ;
(my $start , my $target ) = $line.words ;
my $cols = "abcdefgh" ;
my $rows = "12345678" ;
my @chessFields ;
for ($cols.comb) -> $column {
   for ( $rows.comb) -> $row {
      my $field = $column ~ $row ;
      @chessFields.push( $field ) ;
   }
}
my $count = 1 ;
my @newTargets = findTargets( @chessFields , $start ) ;
my $fieldSet = @newTargets.Set ;
while ( not ( $target (elem) $fieldSet ) ) {
   $count++ ;
   my @nextTargets ;
   for @newTargets -> $tar {
      my @elementsTargets = findTargets( @chessFields , $tar ) ;
      for (@elementsTargets) -> $el {
	 @nextTargets.push( $el ) ;
      }
      @elementsTargets = ( ) ;
   }
   @newTargets = @nextTargets ;
   $fieldSet = @newTargets.Set ;
}
say $count ;
