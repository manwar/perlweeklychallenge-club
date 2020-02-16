use v6 ;
use Slang::Roman ;

sub romanToArab( Str $roman --> Int) {
  my $sum = 0 ;
  my $len = $roman.chars ;
  my %romanToArab = "M" => 1000 , "D" => 500 , "C" => 100 ,
      "L" => 50 , "X" => 10 , "V" => 5 , "I" => 1  ;
  if ( $len == 1 ) {
      return %romanToArab{ $roman } ;
  }
  my $currentIndex = 0 ;
  my $nextIndex = 1 ;
  my $num1 ;
  my $num2 ;
  while ( $currentIndex < $len - 1 ) {
      $num1 = %romanToArab{ $roman.substr( $currentIndex , 1 ) } ;
      $num2 = %romanToArab{ $roman.substr( $nextIndex , 1 ) } ;
      if ( $num1 < $num2 ) {
    $sum += ( $num2 - $num1 ) ;
    $nextIndex += 2 ;
    $currentIndex += 2 ;
      }
      else {
    $sum += $num1 ;
    $nextIndex++ ;
    $currentIndex++ ;
      }
  }
  if ( %romanToArab{ $roman.substr( *-1, 1 ) } <=
    %romanToArab{ $roman.substr( *-2 , 1 ) } ) {
      $sum += %romanToArab{ $roman.substr( *-1 , 1 ) } ;
  }
  return $sum ;
}

sub MAIN( Str $entry ) {
    if  $entry ~~ /^^(<[IVXLCM]>+) \s+ (<[\+\-\/\*]>) \s+  (<[IVXLCM]>+)$$/ {
        my $first_operand = romanToArab( ~$0 ) ;
        my $second_operand = romanToArab( ~$2 ) ;
        my $result ;
        given ( ~$1 ) {
            when '+' { $result = $first_operand + $second_operand }
            when '-' { $result = $first_operand - $second_operand }
            when '/' { $result = $first_operand div $second_operand }
            when '*' { $result = $first_operand * $second_operand }
        }
        say to-roman( $result ) ;
    }
    else {
        say "erroneous entry!" ;
    }
}
