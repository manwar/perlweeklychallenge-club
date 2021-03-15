use v6 ;

subset Pos of Int where * > 0 ;
sub MAIN( Pos $N ) {
  my @elements ;
  my $hashstring ;#the final output
  my $sum = 0 ;
  my $firsttime = True ; #if we enter the loop of adding numbers the
#first time we simply add $N as number
  if ( $N == 1 ) {
      $hashstring = "#" ;
  }
  else {
#we build up an array @elements and push every further element
#in the end, we reverse the array
      @elements.push( '#' ) ;#the last ( first in reversed order ) must be a hash
      $sum += 1 ;
      while ( $sum < $N ) {
    if ( @elements[ *-1 ] ~~ /\d/ ) {#hashes and numbers change
        @elements.push( '#' ) ;#a hash must follow a number
        $sum += 1 ;#update the sum of all the characters
    }
    else {
        my $newNumber ;#the number we add if we don't add a hash
        if ( $firsttime ) {#we enter this loop the first time
          $newNumber = $N ;#and add $N
          $firsttime = False ;
        }
        else {
          $newNumber = $N - ([+] @elements.map( { $_.Str.chars } ) ) + 1 ;
        }
        @elements.push( $newNumber.Str ) ;
        $sum += $newNumber.chars ;#update the sum
        }
        }
    $hashstring = @elements.reverse.join ;#now we reverse the @elements arr.
      }
  say $hashstring ;
}
