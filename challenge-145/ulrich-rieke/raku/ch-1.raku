use v6 ;

say "Enter first number array!" ;
my $line = $*IN.get ;
my @nums1 = $line.split( /\s+/).map( {.Int} ) ;
say "and another number array of the same size!" ;
$line = $*IN.get ;
my @nums2 = $line.split( /\s+/ ).map( {.Int} ) ;
while ( @nums2.elems != @nums1.elems ) {
  say "second array must have the same size as first array! Re-enter!" ;
  $line = $*IN.get ;
  @nums2 = $line.split( /\s+/ ).map( {.Int} ) ;
}
say [+] ( @nums1 Z* @nums2 ) ;
