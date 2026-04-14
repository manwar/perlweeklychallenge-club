use v6 ;

say "Enter a string , a size and a filler, separated by blanks!" ;
my $line = $*IN.get ;
my ( $string , $sizeword , $fillword ) = $line.words ;
my $size = $sizeword.Int ;
my $filler = $fillword.substr( 0 , 1 ) ;
my $seq = $string.comb( $size ) ;
my $last_word = $seq[*-1] ;
my $last_len = $last_word.chars ;
my @ar ; # array if we want to pop the last word from the combed sequence 
#because it is too short
if ( $last_len < $size ) {
   $last_word ~= ($filler x ( $size - $last_len ) ) ;
   for (0..$seq.elems - 2) -> $i {
      @ar.push( $seq[$i] ) ;
   }
   @ar.push( $last_word ) ;
}
if ( @ar ) {
   @ar.say ;
}
else {
   $seq.say ;
}
