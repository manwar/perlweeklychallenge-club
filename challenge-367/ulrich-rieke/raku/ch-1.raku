use v6 ;

sub rearrange( $binary ) {
   my @rearranged ;
   my $len = $binary.chars ;
   my $ones = $binary.comb.grep( { $_ eq '1' } ).elems ;
   return "1" x ( $ones - 1 ) ~ ( "0" x ( $len - $ones )) ~ "1" ;
}

say "Enter a binary with at least one 1!" ;
my $binary = $*IN.get ;
say rearrange( $binary ) ;
