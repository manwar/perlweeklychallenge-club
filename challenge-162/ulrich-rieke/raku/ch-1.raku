use v6 ;

say "Enter an ISBN code without the last digit!" ;
my $isbn = $*IN.get ;
my $converted = $isbn ;
$converted ~~ s:g/\D// ;
while ( $converted.chars != 12 ) {
  say "The ISBN code should only contain 12 digits for this exercise!" ;
  $isbn = $*IN.get ;
  $converted = $isbn ;
  $converted ~~ s:g/\D// ;
}
my @numbers = $converted.comb.map( {.Int} ) ;
my @multipliers ;
for (1 .. 6 ) {
  @multipliers.push( 1 , 3 ) ;
}
my $sum = sum( @numbers Z* @multipliers ) ;
my $check = 10 - ($sum % 10) ;
if ( $check == 10 ) {
  $check = 0 ;
}
say "The correct ISBN number is " ~ ($isbn ~ ~$check) ~ " !" ;
