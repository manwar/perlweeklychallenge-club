use v6 ;

sub MAIN( Int $n is copy ) {
  while ( not ( sqrt( $n ) %% 1 ) ) {
      say "Only perfect squares are allowed! Re-enter number accordingly!" ;
      $n = $*IN.get.Int ;
  }
  my $len = (~$n).chars ;
  my $root = sqrt( $n ) ;
  my @allCombis ;#contains numbers from 1 to $len
  my @numberCombis ;#contains all combinations of 2 and more of numbers from 1 to $len
  my @possibleCombis ;#those combinations that sum up to the length of $n
  my $output = 0 ;
  for ( 1 .. $len ) -> $i {
      my $howmany = $len div $i ;
      for (1 .. $howmany ) {
    @allCombis.push( $i ) ;
      }
  }
#if the sum of all digits equals square root the output is 1
  if ( ~$n.comb.map( { .Int } ).sum == $root ) {
      $output = 1 ;
  }
  else {
      for ( 2 .. $len ) -> $i {
    @numberCombis.push( @allCombis.combinations( $i )) ;
      }
      my $combiLength = @numberCombis.elems ;#the number of subarrays of number
#combinations of 2 or more numbers, it is a sequence of sequences. We iterate through
#it searching for combinations that sum up to the length of the number $n
      for ( 0 .. $combiLength - 1 ) -> $i {
    for (0 .. @numberCombis[$i].elems - 1 ) -> $j {
        if ( (@numberCombis[ $i ][ $j ]).sum == $len ) {
          @possibleCombis.push( @numberCombis[ $i ][ $j ] ) ;
          @possibleCombis.push( @numberCombis[ $i ][ $j ].reverse ) ;
        }
    }
      }
      my $numberstring = ~$n ;
      my %combisFound ;#we want to check every possible combination only once so we
#create a hash of the number combinations we found
      @possibleCombis.map( { %combisFound{$_}++ } ) ;
      for %combisFound.keys -> $combi {#since sequences are hash keys they are converted
#to strings which we must take apart by using comb
    my $sum = 0 ;
    my @nums = $combi.comb.map( {.Int} ) ;
    if ( @nums.elems < $len ) {#we exclude the array of 1's, as many times as $n is
#long since we covered this situation already
        my $currentPos = 0 ;
        for ( 0 .. @nums.elems - 1 ) -> $pos {
          $sum += $numberstring.substr( $currentPos, @nums[ $pos ] ) ;
          $currentPos += @nums[ $pos ] ;
        }
    }
    if ( $sum == $root ) {
        $output = 1 ;
        last ;
    }
      }
  }
  say $output ;
}
