use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
while ( $word ~~ /(.)$0/ ) {
   my $pos = $word.index( ~$0 ) ;
   my @letters = $word.comb ;
   @letters.splice( $pos , 2 , () ) ;
   $word = @letters.join ;
}
say $word ;
