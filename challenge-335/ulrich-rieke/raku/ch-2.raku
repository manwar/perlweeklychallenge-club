use v6 ;

say "Enter some numbers between 0 and 2 in brackets separated by ,!" ;
my $line = $*IN.get ;
my @pairs ;
my @parts = $line.split( /\] ',' \s*\[/ ) ;
for @parts -> $pair {
   if ($pair ~~ /(\d+)\s* ',' \s* (\d+) / ) {
      my $numberpair = [+$0 , +$1] ;
      @pairs.push( $numberpair ) ;
   }
}
#define the tictactoe as an array of strings, for simplicity
my @tictactoe ;
for (1..3) {
   @tictactoe.push( "___") ;
}
my $counter = 0 ;
for @pairs -> $pair {
   if ( $counter %% 2 ) {
      @tictactoe[$pair[0]].substr-rw( $pair[1] , 1 ) = 'A' ;
   }
   else {
      @tictactoe[$pair[0]].substr-rw( $pair[1] , 1 ) = 'B' ;
   }
   $counter++ ;
}
my $row_equal = False ;
for @tictactoe -> $str {
   if ( $str eq "AAA" || $str eq "BBB" ) {
      $row_equal = True ;
   }
}
my @transposed ;
for ( 0..2 ) -> $col {
   for (0..2) -> $row {
      my $transpo ~= @tictactoe[$row].substr( $col , 1 ) ;
   }
   @transposed.push( $transpo ) ;
}
my $column_equal = False ;
for @transposed -> $str {
   if ( $str eq "AAA" || $str eq "BBB" ) {
      $column_equal = True ;
   }
}
my $first_diagonal = @tictactoe[0].substr( 0 , 1 )  ~ @tictactoe[1].substr( 1 , 1 ) 
   ~ @tictactoe[2].substr( 2 , 1 ) ;
my $left_down_diagonal = ( $first_diagonal eq "AAA" || $first_diagonal eq "BBB" ) ;
my $second_diagonal = @tictactoe[2].substr( 0 , 1 ) ~ @tictactoe[1].substr( 1 , 1 ) 
   ~ @tictactoe[0].substr( 2 , 1 ) ;
my $right_up_diagonal = ( $second_diagonal eq "AAA" || $second_diagonal eq "BBB" ) ;
my $maybe_drawn = ( (not $row_equal) && not ( $column_equal ) && ( not 
	 $left_down_diagonal ) && ( not $right_up_diagonal )) ;
my $is_drawn ;
if ( $maybe_drawn ) {
   if ( @tictactoe.grep( {$_ ~~ /^('A' | 'B')+$/ } ).elems == 3 ) {
      $is_drawn = True ;
   }
}
if (( $column_equal , $row_equal , $left_down_diagonal , $right_up_diagonal , 
      $is_drawn ).none ) {
   say "Pending" ;
}
if $row_equal {
   for @tictactoe -> $string {
      if ($string eq "AAA" ) {
	 say "A" ;
      }
      if ( $string eq "BBB" ) {
	 say "B" ;
      }
   }
}
if $column_equal {
   for @transposed -> $string {
      if ( $string eq "AAA" ) {
	 say "A" ;
      }
      if ( $string eq "BBB" ) {
	 say "B" ;
      }
   }
}
if $left_down_diagonal {
   say @tictactoe[0].substr( 0 , 1 ) ;
}
if ( $right_up_diagonal ) {
   say @tictactoe[2].substr( 0 , 1 ) ;
}
if $is_drawn {
   say "Draw" ;
}
