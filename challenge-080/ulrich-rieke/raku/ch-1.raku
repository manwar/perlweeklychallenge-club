use v6 ;

sub enterArray( ) {
  my @array ;
  say "Enter numbers ( 'e' to end ) " ;
  my $line = $*IN.get ;
  while ( $line ne 'e' ) {
      @array.push( +$line ) ;
      say "next number :" ;
      $line = $*IN.get ;
  }
  return @array ;
}

my @array = enterArray( ) ;
my $positiveSet = @array.grep( { $_ > 0 } ).Set ;
my $current = 1 ;
while ( $current (elem) $positiveSet ) {
  $current++ ;
}
say $current ;
