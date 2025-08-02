use v6 ;

say "Enter some operations separated by blanks!" ;
my $opline = $*IN.get ;
my @ops = $opline.words ;
my $value = 0 ;
for @ops -> $op {
   if ( $op ~~ /'+' '+'/ ) {
      $value++ ;
   }
   if ( $op ~~ /'-' '-'/ ) {
      $value-- ;
   }
}
$value.say ;
