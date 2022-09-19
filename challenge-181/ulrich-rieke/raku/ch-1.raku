use v6 ;

my $fh = open 'paragraph.txt' , :r ;
my $contents = $fh.slurp ;
$fh.close ;
my $len = $contents.chars ;
my $output ;
my $startPos = 0 ;
my $pointPos = index( $contents , '.' , $startPos ) ;
while ( $pointPos && $pointPos < $len ) {
  my $sentence = $contents.substr( $startPos , $pointPos - $startPos ) ;
  my @words = $sentence.split( /\s+/ ) ;
  $output ~= @words.sort( { lc($^a) cmp lc($^b) } ).join( ' ' ) ~ '.' ;
  $startPos = $pointPos + 1 ;
  $pointPos = index( $contents, '.' , $startPos ) ;
}
#insert line breaks
my $pos = 55 ;
while ( $pos < $len ) {
  while ( $output.substr( $pos , 1 ) ne " " ) {
      $pos++ ;
  }
  $output.substr-rw( $pos , 1 ) = "\n" ;
  $pos += 55 ;
}
$output ~= "\n" ;
print $output ;
