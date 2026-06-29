use v6 ;

say "Enter a string!" ;
my $word = $*IN.get ;
my $value = 0 ;
my $pos = 1 ;
for $word.comb -> $letter {
   $value += $pos * ( 123 - $letter.ord ) ;
   $pos++ ;
}
$value.say ;
