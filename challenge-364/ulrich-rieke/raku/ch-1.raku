use v6 ;

sub solution( $word is copy , %conversions ) {
   while ( $word ~~ /\d** 2 '#'/ ) {
      $word ~~ s/(\d** 2\#)/%conversions{~$0}/ ;
   }
   while ( $word ~~ /\d/ ) {
      $word ~~ s/(\d)/%conversions{~$0}/
   }
   return $word ;
}

my %conversions ;
my $lowerletters = "abcdefghi" ;
my $upperletters = "jklmnopqrstuvwxyz" ;
for (0..$lowerletters.chars - 1) -> $i {
   %conversions{~($i + 1)} = $lowerletters.substr( $i , 1 ) ;
}
for (0..$upperletters.chars - 1) -> $i {
   %conversions{~($i + 10) ~ "#"} = $upperletters.substr( $i , 1 ) ;
}
say solution( "10#11#12" , %conversions ) ;
say solution( "1326#" , %conversions ) ;
say solution( "25#24#123" , %conversions ) ;
say solution( "20#5" , %conversions ) ;
say solution( "1910#26#" , %conversions ) ;      
