use v6 ;

sub analyze_string( $sentence ) {
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
                  20 => "twenty" ;
   my @allWords = $sentence.words ;
   my $vowels = "AEIOUaeiou" ;
   my $vowelcount = 0 ;
   my $consocount = 0 ;
   for @allWords[0].comb -> $letter {
      if ( $vowels.contains( $letter ) ) {
         $vowelcount++ ;
      }
      else {
         $consocount++ ;
      }
   }
   return %conversions{$vowelcount} eq @allWords[2] && %conversions{$consocount}
    eq @allWords[5] ;
}

say analyze_string( "aa - two vowels and zero consonants") ;
say analyze_string( "iv - one vowel and one consonant") ;
say analyze_string( "hello - three vowels and two consonants") ;
say analyze_string( "aeiou - five vowels and zero consonants") ;
say analyze_string( "aei - three vowels and zero consonants" ) ;
