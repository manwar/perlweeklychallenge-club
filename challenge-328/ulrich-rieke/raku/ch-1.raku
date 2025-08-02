use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
my $characters = ('a'..'z').Set ;
if ( $word ~~ /(.) '?' (.)/ ) {
   my $remaining = $characters (-) (~$0 , ~$1).Set ;
   my $replacement = $remaining.keys[0] ;
   $word ~~ s/'?'/$replacement/ ;
}
say $word ;
