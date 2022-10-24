use v6 ;

say "Enter a list of positive integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s/ ) ;
my @combis = @numbers.combinations( 3 ).Array ;
my @triplets ;
for @combis -> @combi {
  my @permus = @combi.permutations.Array ;
  for @permus -> $tripl {
      @triplets.push( $tripl ) ;
  }
}
@triplets = @triplets.unique(:with(&[eqv])) ;
my $maximum = 0 ;
for @triplets -> @combi {
  if ( @combi.sum > $maximum ) {
      $maximum = @combi.sum ;
  }
}
my @solution = @triplets.grep( { ($_[0] + $_[1] > $_[2]) &&
      ($_[1] + $_[2] > $_[0] ) && ( $_[0] + $_[2] > $_[1] ) &&
      ( $_.sum == $maximum ) } ) ;
if ( @solution.elems > 1 ) {
  @solution = @solution.grep( { ($_[0] >= $_[1]) && ($_[1] >= $_[2])} ) ;
}
say @solution ;
