use v6 ;

say "Enter a first number string!" ;
my $a = $*IN.get ;
while ( $a !~~ /^\d+$/ ) {
  say "The string should only consist of numbers!" ;
  $a = $*IN.get ;
}
say "Enter a second number string!" ;
my $b = $*IN.get ;
while ( $b !~~ /^\d+$/ ) {
  say "The string should only consist of numbers!" ;
  $b = $*IN.get ;
}
while ( $b.chars != $a.chars || $b !~~ /^\d+$/ ) {
  say "second number string should be {$a.chars} characters long!" ;
  say "digits only!" ;
  $b = $*IN.get ;
}
my @fibowords ;
@fibowords.push( $a , $b ) ;
while ( @fibowords[*-1].chars < 51 ) {
  @fibowords.push( @fibowords[*-2] ~ @fibowords[*-1] ) ;
}
say @fibowords[*-1].substr( 50 , 1 ) ;
