use v6 ;

#demonstrating the use of a dispatcher, without much of input validation

sub add( Numeric $a , Numeric $b ) {
  return $a + $b ;
}

sub subtract( Numeric $a , Numeric $b ) {
  return $a - $b ;
}

sub multiply( Numeric $a , Numeric $b ) {
  return $a * $b ;
}

sub divide( Numeric $a , Numeric $b ) {
  return $a / $b ;
}

say "Enter a number from 1 to 4 to indicate what you want to do!" ;
say "1) add" ;
say "2) subtract" ;
say "3) multiply" ;
say "4) divide" ;
my $answer = $*IN.get ;
my $choice = $answer.substr(0, 1 ) ;
while ( +$choice < 1 || +$choice > 4 )  {
  say "Enter a number from 1 to 4 to indicate what you want to do!" ;
  say "1) add" ;
  say "2) subtract" ;
  say "3) multiply" ;
  say "4) divide" ;
  $answer = $*IN.get ;
  $choice = $answer.substr(0, 1 ) ;
}
say "Enter your 2 operands: ( 2 in a row separated by spaces )" ;
my $numberline = $*IN.get ;
my @numbers = $numberline.split(/\s+/) ;
while @numbers.elems < 2 {
  say "Enter your 2 operands: (2 in a row separated by spaces)" ;
  my $numberline = $*IN.get ;
  my @numbers = $numberline.split(/\s+/) ;
}
my %dispatcher = '1' => &add , '2' => &subtract , '3' => &multiply,
  '4' => &divide ;
if ( 1 <= +$choice <= 3 ) {
  say "The result is {%dispatcher{$choice}(+@numbers[0] , +@numbers[1]) }!" ;
}
if (+$choice == 4 ) {
  if (+@numbers[1] == 0) {
      say "Illegal division by 0!" ;
  }
  else {
      say "The result is {%dispatcher{'4'}(+@numbers[0] , +@numbers[1]) }!" ;
  }
}
