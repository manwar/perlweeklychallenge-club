use v5.36.0 ;

say "Enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @strings = split( /\s+/ , $line ) ;
my @reversed = map { join( '' , reverse split( // , $_ ) ) } @strings ;
my %ortho ;
my %rev ;
my %common ;
for my $s ( @strings ) {
   $ortho{$s}++ ;
}
for my $s ( @reversed ) {
   $rev{ $s }++ ;
}
for my $s ( keys %ortho ) {
   if ( exists( $rev{ $s } ) ) {
      $common{$s}++ ;
   }
}
say int (scalar( keys %common ) / 2 ) ;


