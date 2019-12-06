use v6 ;

sub validate_VIN_number( Str $vincode ) returns Bool {
  if ( $vincode ~~ / 'I' | 'Q' | 'O' / ) {
      return False ;
  }
  if ( $vincode.substr( 9 , 1 ) ~~ /<[IQOUZ0]>/ ) {
      return False ;
  }
  if ( $vincode.substr( 9 , 1) !~~ /<[A..Y1..9]>/ ) {
      return False ;
  }
  if ( $vincode ~~ /<[A..Z1..9]-[IOQ]> ** 17/ ) {
    return True ;
  }
  return True ;
}

sub test_check_digit( Str $vincode ) returns Bool {
  my %transliteration_keys = 'A' => 1 , 'B' => 2 , 'C' => 3 , 'D' => 4 ,
                              'E' => 5 , 'F' => 6 , 'H' => 8 , 'J' => 1 ,
                  'K' => 2 , 'L' => 3 , 'M' => 4 , 'N' => 5 ,
                  'P' => 7 , 'R' => 9 , 'S' => 2 , 'T' => 3 ,
                  'U' => 4 , 'V' => 5 , 'W' => 6 , 'X' => 7 ,
                  'Y' => 8 , 'Z' => 9 , 'G' => 7 ;
  my @weights = (8, 7 , 6 , 5 , 4 , 3 , 2 , 10 , 0 , 9 , 8 , 7 , 6 , 5 ,
    4 , 3 , 2 ) ;
  my $sum ;
  for (0..16) -> $i {
      next if $i == 8 ;
      my $letter = $vincode.substr( $i , 1 ) ;
      if ( $letter ~~ /\d/ ) {
    $sum += (@weights[$i] * +$letter) ;
      }
      if ( $letter ~~ /\D/ ) {
    $sum += (@weights[$i] * %transliteration_keys{ $letter }) ;
      }
  }
  if ( $sum % 11 ) == 10 {
      if ( $vincode.substr( 8 , 1 ) eq 'X' ) {
    return True ;
      }
      else {
    return False ;
      }
  }
  else {
      my $remainder = $sum % 11 ;
      if ( $vincode.substr( 8 , 1 ) eq ~$remainder) {
    return True ;
      }
      else {
    return False ;
      }
  }
}

sub MAIN( Str $vincode ) {
  my $vinsign = $vincode.uc ;
  print "$vinsign " ;
  if (validate_VIN_number( $vinsign ) ) {
      say "is valid by European standards!" ;
      if (test_check_digit( $vinsign ) ) {
    say " and additionally by North American standards!" ;
      }
  }
  else {
      say "is not valid!" ;
  }
}
