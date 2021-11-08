use v6 ;

sub toSet( $subarray is copy ) {
  return ($subarray[0] .. $subarray[1]).Set ;
}

sub MAIN( ) {
  my @intervals ;
  say "please enter intervals of integers , end to end!" ;
  say "format: ( <smaller integer>, <greater integer> ) " ;
  my $interval = $*IN.get ;
  while ( $interval ne "end" ) {
      my $smaller ;
      my $greater ;
      if ( $interval ~~ /^^'(' (\d+) ',' (\d+) ')'$$/) {
    if ( +$/[0] < +$/[1] ) {
        $smaller = +$/[0] ;
        $greater = +$/[1] ;
    }
    else {
        $smaller = +$/[1] ;
        $greater = +$/[0] ;
    }
      }
      else {
    say "Enter line ( <smaller integer> , <greater integer> )!" ;
      }
      if ( $smaller && $greater ) {
    @intervals.push( [$smaller , $greater] ) ;
      }
      $interval = $*IN.get ;
  }
  my @solution ;
  my @subsets = @intervals.map( { toSet( $_ ) } ) ;
  my $len = @intervals.elems ;
  for (1 .. $len - 1 ) -> $i {
      for ( 0 .. $i - 1 ) -> $j {
        if ( @subsets[ $i ] (&) @subsets[ $j ] !== set( ) ) {
        @solution.push( '(' ~ @intervals[$i][0] ~ ',' ~
              @intervals[$i][1] ~ ')' ) ;
        last ;
        }
      }
  }
  say @solution ;
}
