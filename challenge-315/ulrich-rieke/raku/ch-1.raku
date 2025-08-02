use v6 ;

say "Enter some words separated by blanks!" ;
my $line = $*IN.get ;
say "Enter a character!" ;
my $char = $*IN.get ;
my @result ;
my $pos = 0 ;
for $line.words -> $word {
   if ( $word ~~ /$char/ ) {
      @result.push( $pos ) ;
   }
   $pos++ ;
}
say '(' ~ @result.join(',') ~ ')' ;
