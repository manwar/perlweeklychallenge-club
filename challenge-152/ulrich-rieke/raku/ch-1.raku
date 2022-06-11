use v6 ;

say "Enter a triangle from top to bottom, separating numbers by spaces!" ;
say "In every line there should be one number more than in the preceding one!" ;
say "To end entry , enter letter e!" ;
my $lastLen = 0 ;
my $len ;
my $pathSum = 0 ;
my $line = $*IN.get ;
while ( $line ne "e" ) {
  while ( $line !~~ /^(\d \s*)+$/ ) {
      say "Enter only numbers and spaces!" ;
      $line = $*IN.get ;
  }
  $len = $line.split( /\s+/ ).elems ;
  unless ( $line eq "e" ) {
      while ( $len != $lastLen + 1 ) {
    say "There should be one more number than the last time!" ;
    $line = $*IN.get ;
    $len = $line.split( /\s+/ ).elems ;
      }
  }
  $lastLen = $len ;
  $pathSum += $line.split( /\s+/ ).map( {.Int} ).min ;
  $line = $*IN.get ;
}
say $pathSum ;
