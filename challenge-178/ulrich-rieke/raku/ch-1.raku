use v6 ;

sub trim-leading-zeroes( Str $numberstring is copy ) {
  $numberstring ~~ s/^(0+)(<[0..3]>+\s2i)$/$1/ ;
  return $numberstring ;
}

sub from_quater-imaginary( Str $numberstring , %quaterHash --> Complex) {
  my Complex $sum = Complex.new( 0 , 0 ) ;
#we reverse the number string , but only all digits before the 2i annex
  my $reversed = $numberstring.substr( 0 , $numberstring.chars - 2).flip ;
  my $len = $reversed.chars ;
  for (0 .. $len - 1 ) -> $position {
      my Complex $firstFactor = Complex.new( +($reversed.substr( $position , 1 )), 0) ;
      $sum += $firstFactor * %quaterHash{ ~$position } ;
  }
  return $sum ;
}

sub into_quater-imaginary( Int $num , %quaterHash ) {
  my @real_only_products ;
  for ( 0 .. 4 ) -> $num {
      @real_only_products.push( %quaterHash{~(2 * $num)} ) ;
  }
#find all combinations of 0 .. 3 that add up to the given integer ,
#where each number is multiplied with the elements of @real_only_products
#that contain the quater-imaginary potences without an imaginary part
  my @solutions ;
  for (0 .. 3 ) -> $a {
      for ( 0 .. 3 ) -> $b {
    for ( 0 .. 3 ) -> $c {
        for ( 0 .. 3 ) -> $d {
          for ( 0 .. 3 ) -> $e {
          if ( @real_only_products[0] * $a + @real_only_products[1] * $b
            + @real_only_products[2] * $c + @real_only_products[3] *
            $d + @real_only_products[4] * $e == $num ) {
            my @possible_solution = ($a , 0 , $b , 0 ,  $c , 0 , $d , 0 , $e ).
            map( {.Str} ) ;
            @solutions.push( @possible_solution.reverse.join.Str ~ " 2i") ;
          }
          }
        }
    }
      }
  }
  return @solutions ;
}

my %powers_of_imaginary ;
%powers_of_imaginary{'0'} = 1 ;
%powers_of_imaginary{'1'} = 2i ;
my @imaginaries = (2i , 2i ) ;
for (2 .. 10 ) -> $num {
  %powers_of_imaginary{~$num} = [*] @imaginaries ;
  @imaginaries.push( 2i ) ;
}
say "Please enter a number string! If it is a quater-imaginary, end entry with '2i'!" ;
my $numberstring = $*IN.get ;
if ( $numberstring ~~ /2i/ ) {
  say from_quater-imaginary( $numberstring , %powers_of_imaginary ) ;
}
else {
  my @solutions = into_quater-imaginary( +$numberstring, %powers_of_imaginary ) ;
  .say for @solutions.map( { trim-leading-zeroes( $_ ) } ) ;
}
