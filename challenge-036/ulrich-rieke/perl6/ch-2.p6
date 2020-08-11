use v6 ;

sub computeSubsums( Str $l ) {
  my %packages = "R" => [1 , 1 ] , "B" => [1 , 2] , "G" => [2, 2 ] ,
          "Y" => [12 , 4 ] , "P" => [4 , 10] ;
  my $result ;
  my $totalweight ;
  my $totalsum ;
  for $l.comb -> $element {
      $totalweight += %packages{$element}[0] ;
      $totalsum += %packages{$element}[1] ;
  }
  $result.push( $l , $totalweight , $totalsum) ;
  return $result ;
}
my @results ;
#The code below compares 2 , 3 , or 4 packages. If we were to compare
#2 packages only all we'd have to do is comment out the lines containing
#@combis1 and @combis2
#Beware: the combinations routine if fantastic, but in order to work
#with is in any meaningful way I had to convert it into an array. As
#long as it was a sequence( which combinations produces ) it caused
#strange error messages
my @combis1 = "RBGYP".comb.combinations( 4 ).Array ;
my @combis2 = "RBGYP".comb.combinations( 3 ).Array ;
my @combis3 = "RBGYP".comb.combinations( 2 ).Array ;
for @combis1 -> $sublist {
  @results.push( computeSubsums( $sublist.join )) ;
}
for @combis2 -> $sublist {
  @results.push( computeSubsums( $sublist.join )) ;
}
for @combis3 -> $sublist {
  @results.push( computeSubsums( $sublist.join )) ;
}
my @withinWeight = @results.grep( { $_[1] <= 15 }) ;
my @sorted = @withinWeight.sort( {$^b[2] <=> $^a[2] } ) ;
print "The packages { @sorted[0][0].comb}" ;
say " have a weight of {@sorted[0][1] } kg " ~
"and a value of {@sorted[0][2]} pounds !" ;
