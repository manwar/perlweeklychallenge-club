#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findDigitConversion {
   my $number = shift ;
   my $conversion = shift ;
   my $len = length $number ;
   my $result = "" ;
   if ( $len == 1 ) {
      $result .= $conversion->{$number} ;
   }
   if ( $len == 2 ) {
      if ( $number % 10 == 0 ) {
         $result .= $conversion->{$number} ;
      }
      else {
         $result .= $conversion->{int( $number / 10 )} . "-" . 
            $conversion->{$number % 10 } ;
      }
   }
   if ( $len == 3 ) {
      if ( $number % 100 == 0 ) {
         $result .= $conversion->{ $number / 100  } . " hundred" ;
      }
      else {
         $result .= $conversion->{int( $number / 100 ) } . " hundred and " .
            findDigitConversion( $number % 100 , $conversion ) ;
      }
   }
   if ( $len > 3 && $len < 7 ) {
      if ( $number % 1000 == 0 ) {
         $result .= $conversion->{ $number / 1000 } . " thousand" ;
      }
      else {
         $result .= $conversion->{int( $number / 1000 )} . " thousand " .
            findDigitConversion( $number % 1000 , $conversion ) ;
      }
   }
   if ( $len > 6 && $len < 10 ) {
      if ( $number % 1000000 == 0 ) {
         $result .= $conversion->{$number / 1000000 } . " million" ;
      }
      else {
         $result .= $conversion->{int( $number / 1000000)} . " million " .
            findDigitConversion( $number % 1000000 , $conversion) ;
      }
   }
   return $result ;
}

sub compose {
   my $number = shift ;
   my $conversions = shift ;
   my $string ;
   if ( $number < 0  ) {
      $string .= "minus " ;
   }
   my $abs_number = abs( $number ) ;
   $string .= findDigitConversion( $abs_number , $conversions ) ;
   return $string ;
}

my %conversions = ( 0 => "zero" , 
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
                    40 => "forty" , 
                    50 => "fifty" , 
                    60 => "sixty" , 
                    70 => "seventy" ,
                    80 => "eighty" , 
                    90 => "ninety" ) ;
say "Enter some integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @sorted = sort { compose( $a , \%conversions ) cmp compose( $b , \%conversions ) } 
 @numbers ;
say join( ',' , @sorted ) ; 
