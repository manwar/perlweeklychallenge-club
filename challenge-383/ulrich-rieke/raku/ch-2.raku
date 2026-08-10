use v6 ;

sub roundRGB( $color , %websafes , %conversion) {
   my $converted ;
   $converted ~= '#' ;
   my $colorpart = $color.substr( 1 ) ;
   for (0..2 ) -> $i {
      my $part = $colorpart.substr(2 * $i , 2 ) ;
      my $number = %conversion{$part.substr( 0 , 1 ) } * 16 +
         %conversion{$part.substr( 1 , 1 ) } ;
      my @sorted = %websafes.values.sort( {abs( $^a - $number) <=> 
            abs( $^b - $number ) } ) ;
      my %hex_to_value ;
      for %websafes.keys -> $key {
         my $val = %websafes{$key} ;
         %hex_to_value{ $val } = $key ;
      }
      $converted ~= %hex_to_value{@sorted[0]} ;
   }
   return $converted ;
}

say "Enter a RGB color!" ;
my $color = $*IN.get ;
my $helper = "ABCDEF" ;
my %conversion ;
%conversion{0} = "00" ;
for (1..9) -> $num {
   %conversion{$num.Str} = $num ;
}
my $n = 10 ;
for $helper.comb -> $letter {
   %conversion{$letter} = $n ;
   $n++ ;
}
my %websafes = "00" => 0 , "33" => 51 , "66" => 102 , "99" => 153 , "CC" => 
   204 , "FF" => 255 ;
say roundRGB( $color , %websafes , %conversion ) ;   
