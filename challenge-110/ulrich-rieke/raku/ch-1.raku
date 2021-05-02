use v6 ;

sub isValid( Str $phonenumber ) {
  return $phonenumber ~~ /^ ('(' \d \d ')' || \d ** 4 ||\s* '+' \d \d ) \s
    \d ** 10 $/ ;
}

my @numbers = 'numbers'.IO.lines ;
my @correctNumbers = @numbers.grep( {isValid( $_)} ) ;
.say for @correctNumbers ;
