use v6 ;

sub parse_complex( $number ) {
   my $real ;
   my $imaginary ;
   if ( $number ~~ /^(\-?\d+)\+(.+)i$/ ) {
      $real = +$0 ;
      my $imagepart = ~$1 ;
      if ( $imagepart ~~ /^\((\-\d+)/ ) {
         $imaginary = +$0 ;
      }
      else {
         $imaginary = +$imagepart ;
      }
   }
   my @array = ($real , $imaginary ) ;
}

say "Enter two complex numbers as strings!" ;
my $line = $*IN.get ;
my @numbers = $line.words ;
my @first = parse_complex( @numbers[0] ) ;
my @second = parse_complex( @numbers[1] ) ;
my $c1 = Complex.new( @first[0] , @first[1] ) ;
my $c2 = Complex.new( @second[0] , @second[1] ) ;
my $result = $c1 * $c2 ;
say $result ;
