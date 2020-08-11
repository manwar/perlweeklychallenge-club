use v6 ;

#defining the possible number range appears to be more practical than a
#complicated regular expression
sub isValidOctet( Str $number --> Bool ) {
  return 0 <= +$number <= 255 ;
}

#finds all the possible length combinations that add up to the total
#length of the input. We know : every octet has 1 to 3 digits
sub findPossibleOctetLengths( Int $len ) {
  my @possibleLengths ;
  for (1 .. 3 ) -> $firstOctet {
      for (1 .. 3 ) -> $secondOctet {
    for (1 .. 3 ) -> $thirdOctet {
        for (1 .. 3 ) -> $fourthOctet {
          if ( $firstOctet + $secondOctet + $thirdOctet
            + $fourthOctet == $len ) {
          my @combi = ( $firstOctet , $secondOctet ,
            $thirdOctet, $fourthOctet ) ;
          @possibleLengths.push( @combi ) ;
          }
        }
    }
      }
  }
  return @possibleLengths ;
}

my Str $ip = prompt "Enter a possible IP string ! " ;
while ( $ip !~~ /\d ** 4..12/ ) {
  say "invalid input!" ;
  $ip = prompt "Enter a possible IP string ! " ;
}
my @possibleIPs ;
my $len = $ip.chars ;
my @lengthCombinations = findPossibleOctetLengths( $len ) ;
#cut out the different length combinations out of the ip and check for validity
for @lengthCombinations -> @combi {
  my @parts ;
  my $pos = 0 ;
  @parts.push( $ip.substr( $pos , @combi[ 0 ] )) ;
  $pos += @combi[ 0 ] ;
  @parts.push( $ip.substr( $pos , @combi[ 1 ] ) ) ;
  $pos += @combi[ 1 ] ;
  @parts.push( $ip.substr( $pos , @combi[ 2 ] ) ) ;
  $pos += @combi[ 2 ] ;
  @parts.push( $ip.substr( $pos ) ) ;
#all possible 4 octets must be valid
  if ( @parts.grep( { isValidOctet( $_ ) } ).elems == 4 ) {
      @possibleIPs.push( @parts.join('.') ) ;
  }
}
if ( @possibleIPs ) {
  say "The following IP's can be constructed from $ip:" ;
  .say for @possibleIPs ;
}
else {
  say "No valid IP can be constructed!" ;
}
