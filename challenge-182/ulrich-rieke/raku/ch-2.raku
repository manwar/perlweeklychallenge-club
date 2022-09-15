use v6 ;

#the basic idea is to jump forward letter by letter in the first path
#and to count the number of occurrences of that letter in the other
#directories. if that number is smaller than the number of directories
#we have reached the end of the common path
my @directories = 'inputfiles.txt'.IO.lines ;
my $comparedTo = @directories[0] ;
my $count = 0 ; #how many other directories have the same letter ?
my $pos = -1 ;#my position in the directory names
my $len = @directories.elems ;
repeat {
  $pos++ ;#one position further to the right
  $count = 0 ;
  for ( 1 .. $len - 1 ) -> $i {
      if ( @directories[$i].substr( $pos , 1 ) eq
        $comparedTo.substr( $pos, 1 )) {
    $count++ ;
      }
  }
} until ( $count < @directories.elems - 1 ) ;
say $comparedTo.substr(0 , $pos ) ;
