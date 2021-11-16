use v6 ;

say "Enter a list of numbers, separated by a blank! ( blank at the end )" ;
my $line = $*IN.get ;
while ( $line !~~ /^\s* (\d+ \s)+ $/ ) {
  say "Please enter a list of numbers, separated by a blank" ;
  say "put a blank at the end! " ;
  $line = $*IN.get ;
}
my @list = $line.split( /\s/ ) ;
my @sorted = @list.sort ;
if ( @sorted.join eq @list.join ) {
  say "1" ;
}
else {
  say "0" ;
}
