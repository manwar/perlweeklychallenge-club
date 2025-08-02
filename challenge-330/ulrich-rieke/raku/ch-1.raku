use v6 ;

say "Enter a string consisting of lowercase English letters and digits!" ;
my $word = $*IN.get ;
while ( $word ~~ /(\D\d)/ ) {
   my $part = ~$0 ;
   $word ~~ s/$part// ;
}
if ( $word ) {
   say $word ;
}
else {
   say "\"\"" ;
}
