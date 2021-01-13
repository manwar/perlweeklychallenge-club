use v6 ;

sub enterArray( ) {
  my @array ;
  my $element = prompt "Enter a list element: (end to end) : " ;
  while ( $element ne "end" ) {
      if ( +$element ~~ Int ) {
    @array.push( $element ) ;
    $element = prompt "Enter a list element: (end to end) : " ;
      }
  }
  return @array ;
}

my @A = enterArray( ) ;
my $len = @A.elems ;
my %howmany ;
while ( @A ) {
  %howmany{ @A.shift }++ ;
}
my $majority = floor( $len / 2 ) ;
my @sorted = %howmany.keys.sort( { %howmany{ $^b } <=> %howmany{ $^a } } ) ;
if ( %howmany{@sorted[ 0 ]} > $majority ) {
  @sorted[0].say ;
}
else {
  say -1 ;
}
