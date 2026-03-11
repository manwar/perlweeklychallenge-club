use v6 ;

sub solution( $word is copy ) {
   $word ~~ s:g/\(\)/o/ ;
   $word ~~ s:g/\(al\)/al/ ;
   return $word ;
}
say solution( "G()(al)" ) ;
say solution( "G()()()()(al)" ) ;
say solution("(al)G(al)()()" ) ;
say solution( "()G()G" ) ;
say solution( "(al)(al)G()()" ) ;
