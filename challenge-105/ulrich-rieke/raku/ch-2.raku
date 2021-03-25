use v6 ;

sub MAIN( Str $name ) {
  my $y ; #the string to be affixed to the rhyme
  my @components = ("bo-b" , "Bonana-fanna fo-f" , "Fee fi mo-m" ) ;
  if ( $name.substr(0 , 1).lc ~~ /<[aeiou]>/ ) {
      $y = $name.lc ;
  }
  else {
      if ( $name.substr( 0 , 1 ).lc ~~ /<[bfm]>/ ) {
    my $firstLetter = $name.substr( 0 , 1 ).lc ;
    for @components <-> $rhyme {
        my $len = $rhyme.chars ;
        if ( $rhyme.substr( $len - 1 , 1 ) eq $firstLetter ) {
          $rhyme = $rhyme.substr(0 , $len - 1 ) ;
        }
        }
      }
      $y = $name.substr( 1 ) ;
  }
  say "$name, $name , {@components[0]}$y" ;
  @components[1..2].map( { say "$_$y" } ) ;
  say "$name!" ;
}
