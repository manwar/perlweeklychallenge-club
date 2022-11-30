use v6 ;
#find the final difference in a string
sub findDifference( Str $word --> Int ) {
  my @posValues = $word.comb.map( { ord( $_ ) - 97  } ) ;
  my @differences = @posValues.rotor( 2 => -1 ) ;
  my @results ; #here we keep the differences
  while ( @results.elems != 1 ) {
      for @differences -> @positions {
    @results.push( @positions[1] - @positions[0] ) ;
      }
      if ( @results.elems > 1 ) {
    @differences = ( ) ;
    for @results -> $num {
        @differences.push( $num ) ;
    }
    @results = ( ) ;
    @differences = @differences.rotor( 2 => -1 ) ;
      }
  }
  return @results[ 0 ] ;
}

#We assume that one string stands out! As far as I can see it from
#the task it may be the only string with a final difference value
#of under 0 , 0 or over 0, but since I'm far from sure if that is
#what you mean and whether it is always possible to uniquely identify
#such a string, I provide a possible result saying precisely this
say "Enter some strings of equal length, separated by blanks!" ;
my $line = $*IN.get ;
my @strings = $line.split( /\s/ ) ;
my %stringDifferences ;
for @strings -> $str {
  %stringDifferences{ $str } = findDifference( $str ) ;
}
my @differenceNumbers = %stringDifferences.values( ) ;
my @underNils = @differenceNumbers.grep( { $_ < 0 } ) ;
my @nils = @differenceNumbers.grep( { $_ == 0 } ) ;
my @overNils = @differenceNumbers.grep( { $_ > 0 } ) ;
my $result ;
if ( @underNils.elems == 1 ) {
  $result = @strings.grep( { %stringDifferences{ $_ } < 0 } )[0] ;
}
elsif ( @nils.elems == 1 ) {
  $result = @strings.grep( { %stringDifferences{ $_ } == 0 })[0] ;
}
else {
  if ( @overNils.elems > 1 ) {
      $result = "I cannot find the distinctive odd string!" ;
  }
  else {
      $result = @strings.grep( { %stringDifferences{ $_ } > 0 })[0] ;
  }
}
say $result ;
