use v6 ;

say "Please enter some integers separated by spaces (minimum of 3)!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s+/ ) ;
while ( @numbers.elems < 3 ) {
  say "Enter at least 3 integers!" ;
  $line = $*IN.get ;
  @numbers = $line.split( /\s+/ ) ;
}
my $found = False ;
my $len = @numbers.elems ;
for ( 1 .. $len - 2 ) -> $i {
  if ( ([+] @numbers[0 .. $i - 1]) == ([+] @numbers[$i + 1 .. $len - 1]) ) {
      say $i ;
      $found = True ;
      last ;
  }
}
say "-1 as no Equilibrium Index found!" unless $found ;
