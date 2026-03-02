use v6 ;

sub convert_one_digit( $number , %conversions ) {
   return %conversions{$number} ;
}

sub convert_more_than_one_dig( $number , %conversions ) {
   my $numstring = ~$number ;
   my $len = $numstring.chars ;
   my $totalstring ;
   my $abs_number = $number.abs ;
   my $corrected = ~$abs_number ;
   my $cor_len = $corrected.chars ;
   if ( $cor_len == 2 ) {
      if ( $abs_number %% 10 ) {
         $totalstring ~= %conversions{$abs_number} ;
      }
      else {
         $totalstring ~= %conversions{ ($abs_number div 10) * 10 } ;
         $totalstring ~= "-" ;
         $totalstring ~= %conversions{ $abs_number % 10 } ;
      }
   }
   if ( $cor_len == 3 ) {
      if ( $abs_number %% 100 ) {
         $totalstring ~= %conversions{ $abs_number div 100 } ;
         $totalstring ~= " hundred" ;
      }
      else {
         my $firstnum = $abs_number div 100 ;
         $totalstring ~= convert_one_digit( $firstnum , %conversions ) ;
         $totalstring ~= " hundred and " ;
         my $remainder = $abs_number % 100 ;
         if ( (~$remainder).chars == 1 ) {
            $totalstring ~= convert_one_digit( $remainder , %conversions ) ;
         }
         else {
            $totalstring ~= convert_more_than_one_dig( $abs_number % 100 , %conversions ) ;
         }
      }
   }
   if ( $cor_len > 3 && $cor_len < 7 ) {
      if ( $abs_number %% 1000 ) {
         my $start = $abs_number div 1000 ;
         if (~$start).chars == 1 {
            $totalstring ~= convert_one_digit( $start , %conversions ) ;
         }
         else {
            $totalstring ~= convert_more_than_one_dig( $abs_number div 1000 ,
                  %conversions ) ;
         }
         $totalstring ~= " thousand" ;
      }
      else {
        $totalstring ~= convert_more_than_one_dig( ($abs_number div 1000) * 1000 , 
              %conversions ) ;
        $totalstring ~= " thousand " ;
        my $remainder = $abs_number % 1000 ;
        if (~$remainder).chars == 1 {
           $totalstring ~= convert_one_digit( $remainder , %conversions ) ;
        }
        else {
           $totalstring ~= convert_more_than_one_dig( $remainder , %conversions ) ;
        }
      }
   }
   if ( $cor_len > 6 && $cor_len < 10 ) {
      if ( $abs_number %% 1000000 ) {
         my $start = $abs_number div 1000000 ;
         if ( ~$start).chars == 1 {
            $totalstring ~= convert_one_digit( $start , %conversions ) ;
         }
         else {
            $totalstring ~= convert_more_than_one_dig( $start , %conversions ) ;
         }
         $totalstring ~= " million" ;
      }
      else {
         my $start = ($abs_number div 1000000 ) * 1000000 ;
         if ( ~$start).chars == 1 {
            $totalstring ~= convert_one_digit( $start , %conversions ) ;
         }
         else {
            $totalstring ~= convert_more_than_one_dig( $start , %conversions ) ;
         }
         my $remainder = $abs_number % 1000000 ;
         if ( ~$remainder).chars == 1 {
            $totalstring ~= convert_one_digit( $remainder , %conversions ) ;
         }
         else {
            $totalstring ~= convert_more_than_one_dig( $remainder , %conversions ) ;
         }
      }
   }
   if ( $cor_len > 9 && $cor_len < 13 ) {
      if ( $abs_number %% 1000000000 ) {
         my $start = $abs_number div 1000000000 ;
         if ( ~$start).chars == 1 {
            $totalstring ~= convert_one_digit( $start , %conversions ) ;
         }
         else {
            $totalstring ~= convert_more_than_one_dig( $start , %conversions ) ;
         }
         $totalstring ~= " billion" ;
      }
      else {
         my $start = ($abs_number div 1000000000 ) * 1000000000 ;
         if ( ~$start).chars == 1 {
            $totalstring ~= convert_one_digit( $start , %conversions ) ;
         }
         else {
            $totalstring ~= convert_more_than_one_dig( $start , %conversions ) ;
         }
         my $remainder = $abs_number % 1000000000 ;
         if ( ~$remainder).chars == 1 {
            $totalstring ~= convert_one_digit( $remainder , %conversions ) ;
         }
         else {
            $totalstring ~= convert_more_than_one_dig( $remainder , %conversions ) ;
         }
      }
   }
   return $totalstring ;
}

sub total_convert( $number , %conversions) {
   my $numberstring = ~$number ;
   my $string ;
   if ( $numberstring.substr( 0 , 1 ) eq "-" ) {
      $string ~= "minus " ;
   }
   my $abs_number = $number.abs ;
   if ( ~$abs_number).chars == 1 {
      $string ~= convert_one_digit( $abs_number , %conversions ) ;
   }
   else {
      $string ~= convert_more_than_one_dig( $abs_number , %conversions ) ;
   }
   return $string ;
}

my %conversions = 0 => "zero" , 
                  1 => "one" , 
                  2 => "two" , 
                  3 => "three" , 
                  4 => "four" , 
                  5 => "five" , 
                  6 => "six" , 
                  7 => "seven" , 
                  8 => "eight" , 
                  9 => "nine" , 
                  10 => "ten" , 
                  11 => "eleven" , 
                  12 => "twelve" , 
                  13 => "thirteen" , 
                  14 => "fourteen" , 
                  15 => "fifteen" , 
                  16 => "sixteen" , 
                  17 => "seventeen" , 
                  18 => "eighteen" , 
                  19 => "nineteen" , 
                  20 => "twenty" , 
                  30 => "thirty" , 
                  40 => "fourty" , 
                  50 => "fifty" , 
                  60 => "sixty" , 
                  70 => "seventy" , 
                  80 => "eighty" , 
                  90 => "ninety" ;
say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
@numbers .= sort( { total_convert( $^a, %conversions) leg total_convert( $^b , 
         %conversions) } ) ;
say @numbers.join( ',' ) ;
