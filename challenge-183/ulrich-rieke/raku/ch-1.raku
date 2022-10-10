use v6 ;

say "Please enter an even number of integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s+/ ).map( {.Int} ) ;
unless ( @numbers.elems %% 2 ) {
  say "For the purposes of this task , enter an even number of integers!" ;
  $line = $*IN.get ;
  @numbers = $line.split( /\s+/ ).map( {.Int} ) ;
}
my @list ;
my %seen ;
while ( @numbers ) {
  my $a = shift @numbers ;
  my $b = shift @numbers ;
  my $pair = [ $a , $b ] ;
  @list.push( $pair ) ;
}
print "[" ;
for @list -> $p {
  unless ( %seen{ "$p[0],$p[1]" }:exists ) {
      print "[" ~ $p[0] ~ "," ~ $p[1] ~ "]" ;
  }
  %seen{ "$p[0],$p[1]" }++ ;
}
say "]" ;
