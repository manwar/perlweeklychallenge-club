use v6 ;

sub convert( $word is copy ) {
   $word ~~ s:g/<punct>// ;
   $word .= lc ;
   return $word ;
}

sub contains( $word , @array) {
   for @array -> $w {
      if ( $w eq $word ) {
         return True ;
      }
   }
   return False ;
}

say "Enter a paragraph!" ;
my $paragraph = $*IN.get ;
say "Enter some banned words separated by blanks!" ;
my $line = $*IN.get ;
my @banned = $line.words ;
my @para = $paragraph.words ;
if ( @para.elems == 1 ) {
   my $leader = @para[0] ;
   $leader ~~ s:g/<punct>/' '/ ;
   @para = $leader.words ;
}
my @converted = @para.map( {convert( $_ )} ) ;
my %frequencies ;
for @converted -> $wo {
   if ( not contains( $wo , @banned ) ) {
      %frequencies{$wo}++ ;
   }
}
my @sorted = %frequencies.keys.sort( {%frequencies{$^b} <=> 
      %frequencies{$^a} } ) ;
say @sorted[0] ;

