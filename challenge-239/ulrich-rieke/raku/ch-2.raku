use v6 ;

sub myCondition( $aString is copy, $allowedSet ) {
   my $letterSet = $aString.comb.Set ;
#the condition is fulfilled if the letterSet is a subset of allowedSet
#or is equal to it
   return $letterSet (<=) $allowedSet ;
}

say "Enter some strings, separated by blanks!" ;
my $line = $*IN.get ;
my @strings = $line.words ;
say "Enter an allowed string!" ;
my $allowed = $*IN.get ;
my $allowedSet = Set.new( $allowed.comb ) ;
my @consistent = @strings.grep( { myCondition( $_ , $allowedSet ) } ) ;
say @consistent.elems ;
