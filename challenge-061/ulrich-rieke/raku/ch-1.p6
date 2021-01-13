use v6 ;

sub enterList {
  my @input ;
  my $number = prompt "Enter next number ( 'e' to end! ) : " ;
  while ( ~$number ne 'e' ) {
      @input.push( $number ) ;
      $number = prompt "Enter next number ( 'e' to end! ) : " ;
  }
  return @input ;
}

sub findSublists( @array ) {
  my $len = @array.elems ;
  my @sublists ;
  for ( 0 .. $len - 2 ) -> $start {
      for ( $start + 1 .. $len -1 ) -> $end {
    my @sublist = @array[$start..$end] ;
    @sublists.push( @sublist ) ;
      }
  }
  return @sublists ;
}

my @input = enterList( ) ;
while ( @input.elems < 4 ) {
  say "There should be at least 4 elements!" ;
  @input = enterList( ) ;
}
my @sublists = findSublists( @input ) ;
my %producthash ;
for @sublists -> @list {
  my $prod = [*] @list ;
  %producthash{ $prod } = @list ;
}
my $biggest_product = %producthash.keys.max ;
print "The sublist with the biggest product ($biggest_product) " ;
say " is [{%producthash{$biggest_product}.join( ',' )}] !" ;

