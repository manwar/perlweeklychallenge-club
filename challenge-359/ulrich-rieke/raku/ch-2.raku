use v6 ;

say "Enter a word consisting of alphabetic letters only!" ;
my $word = $*IN.get ;
while ( $word ~~ /(.) $0/ ) {
   $word.subst-mutate( /(.) $0/, "" ) ;
}
if ( $word.chars == 0 ) {
   say "\"\"" ;
}
else { 
   say $word  ;
}

