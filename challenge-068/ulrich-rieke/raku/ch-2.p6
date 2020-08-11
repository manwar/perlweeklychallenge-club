use v6 ;

sub mergeArrays( @firstArray, @secondArray ) {
  my @merged ;
  for (0..@firstArray.elems + @secondArray.elems - 1 ) {
      if ( @firstArray ) {
    @merged.push( @firstArray.shift ) ;
      }
      if ( @secondArray ) {
    @merged.push( @secondArray.shift ) ;
      }
  }
  return @merged ;
}

sub enterArray( ) {
  my @array ;
  my $element = prompt "Enter a list element: (end to end) : " ;
  while ( $element ne "end" ) {
      @array.push( $element ) ;
      $element = prompt "Enter a list element: (end to end) : " ;
  }
  return @array ;
}

my @array = enterArray( ) ;
my @original = @array ;
my $len = @array.elems ;
my $half = $len div 2 ;
my @firstHalf = @array[0..$half - 1] ;
my @secondHalf = @array[$half..$len - 1] ;
my @reversed = @secondHalf.reverse ;
my @reordered = mergeArrays( @firstHalf, @reversed ) ;
say "The original list:" ;
@original.join("->").say ;
say "reordered:" ;
@reordered.join( "->").say ;
