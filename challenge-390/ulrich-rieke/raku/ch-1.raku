use v6 ;

sub expandInner( $multiplier , $innerstring) {
   return $innerstring x $multiplier ;
}

say "Enter a term!" ;
my $term = $*IN.get ;
while ( $term ~~ /(\d+) '[' (<[a..z]>) ']'/ ) {
   my $number = $0.Int ;
   my $inner = $1.Str ;
   my $replacement = expandInner( $number , $inner ) ;
   $term ~~ s/(\d+) '[' (<[a..z]>) ']'/$replacement/ ;
}
while ( $term ~~ /(\d+) '[' (<[a..z]> ** 2..*) ']'/ ) {
   my $number = $0.Int ;
   my $inner = $1.Str ;
   my $replacement = expandInner( $number , $inner ) ;
   $term ~~ s/(\d+) '[' (<[a..z]> ** 2..*) ']'/$replacement/ ;
}
say $term ;



