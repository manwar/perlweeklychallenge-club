use v6 ;

sub conversion_table( ) {
   my %conversions ;
   for (0..9) -> $i {
      %conversions{$i} = chr( $i + 48 ) ;
   }
   for (10..36) -> $i {
      %conversions{$i} = chr( $i + 55 ) ;
   }
   for (37..63) -> $i {
      %conversions{$i} = chr( $i + 61 ) ;
   }
   %conversions{ 64 } = '+' ;
   %conversions{ 65 } = '/' ;
   my %result ;
   for %conversions.keys -> $k {
      %result{%conversions{$k}} = $k ;
   }
   return %result ;
}

sub convert( $numberstring is copy , $base , %conversion ) {
   my $multiplier = 1 ;
   my $result = 0 ;
   for ( $numberstring.comb.reverse ) -> $c {
      my $factor = $multiplier * %conversion{ $c } ;
      $result += $factor ;
      $multiplier *= $base ;
   }
   return $result ;
}

say "Enter a numberstring in a given base!" ;
my $numberstring = $*IN.get ;
say "Enter a base!" ;
my $basestr = $*IN.get ;
my $base = $basestr.Int ;
my %table = conversion_table( ) ;
say convert( $numberstring , $base , %table ) ;
