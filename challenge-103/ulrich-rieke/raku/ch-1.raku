use v6 ;

sub MAIN( Int $year ) {
  my @animalsuccession = ("Rat" , "Ox" , "Tiger" , "Rabbit" , "Dragon" , "Snake" ,
    "Horse" , "Goat" , "monkey" , "Rooster", "Dog" , "Pig" ) ;
  my @elements = ("Wood" , "Fire" , "Earth" , "Metal" , "Water" ) ;
  my $animallen = @animalsuccession.elems ;
  my $elementlen = @elements.elems ;
  my $yeardiff = $year - 1924 ;
  my $animal = $yeardiff % $animallen ;
  my $element = ( $yeardiff div 2 ) % $elementlen ;
  say "@elements[ $element ] @animalsuccession[ $animal ]" ;
}
