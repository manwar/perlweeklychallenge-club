use v6 ;

sub enterData( ) {
  say "Enter intervals!" ;
  my $S = $*IN.get ;
  while ( $S !~~ /('(' (\d+) ',' (\d+) ')' ',' \s*)+/ ) {
      say "Wrong entry! Enter non overlapping intervals!" ;
      $S = $*IN.get ;
  }
  say 'Enter $N! ' ;
  my $N = $*IN.get ;
  while ( $N !~~ /'(' (\d+) ',' (\d+) ')'/ ) {
      say "Enter one pair, enclosed in brackets!" ;
      $N = $*IN.get ;
  }
  return ( $S , $N ) ;
}

sub createSet( Str $pair ) {
  $pair ~~ /'(' (\d+) ',' (\d+) ')'/  ;
  return ($0.Int .. $1.Int).Set ;
}

sub stringFromSet( Set $theSet --> Str ) {
  return ('(' ~ ~$theSet.min.key ~ ',' ~$theSet.max.key ~ ')' );
}

my ($S , $N) = enterData( ) ;
my @allSets = $S.split( /',' \s+/).map( { createSet( $_ ) } ) ;
my Set $nset = createSet( $N ) ;
my Bool $unionFormed = False ;
my @allUnions ;
for @allSets -> $elem {
  if ( my $inters = $elem (&) $nset ) {
      my $union = $elem (|) $nset ;
      $unionFormed = True ;
      @allUnions.push( $union ) ;
  }
  else {
      @allUnions.push( $elem ) ;
  }
}
my $output ; #that's the string for the final output
if ( $unionFormed == False ) { #not a single union with $N
  @allUnions.push( $nset ) ;
  @allUnions .= sort( {$^a.min.key <=> $^b.min.key} ) ;
#we can output the final result, no intersections and therefore no unions
  for @allUnions -> $elem {
      $output ~= (stringFromSet( $elem ) ~ " ") ;
  }
}
else {
  if ( @allUnions.elems == 1 ) {
      $output = stringFromSet( @allUnions[0] ) ;
  }
  if ( @allUnions.elems == 2 ) {
      if ( my $inters = @allUnions[ 0 ] (&) @allUnions[ 1 ] ) {
    my $union = @allUnions[ 0 ] (|) @allUnions[ 1 ] ;
    $output = stringFromSet( $union ) ;
      }
      else {
    @allUnions.map( { $output ~= (stringFromSet( $_ ) ~ " ") } ) ;
      }
  }
  if ( @allUnions.elems > 2 ) {
      my @finalElements ; #takes the results of pairwise union forming
      my $lastelem = @allUnions.shift( ) ;
      while ( @allUnions ) {
    my $nextelem = @allUnions.shift ;
    if ( my $inters = $lastelem (&) $nextelem ) {
        my $union = $lastelem (|) $nextelem ;
        $lastelem = $union ;
    }
    else {
        @finalElements.push( $lastelem ) ;
        $lastelem = $nextelem ;
    }
      }
      @finalElements.push( $lastelem ) ;
      for @finalElements -> $elem {
    $output ~= stringFromSet( $elem ) ~ " " ;
      }
  }
}
$output .= trim ;
$output ~~ s:g/\s/\, / ;
say $output ;
