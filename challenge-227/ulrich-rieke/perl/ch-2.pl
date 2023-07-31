#!/usr/bin/perl ;
use strict ; 
use warnings ;
use feature 'say' ;
use POSIX ;

sub romanToArab {
   my $number = shift ;
   my $associations = shift ;#reference to the table with all associations of
                             #Roman to Arab numbers
   if ( exists( $associations->{$number} ) ) {
      return $associations->{$number} ;
   }
   else {
#go letter by letter to the right of the Roman number until the substring
#is no longer found in the association table. There, go one step back and add
#the association found to the sum of Roman numbers. Repeat that same procedure
#at the end of the string
   my $sum = 0 ;
   my $len = length $number ;
   my $start = 0 ;
   my $howmany = 1 ; #number of digits I take at the given start position
   my $sub ;
   while ( $start + $howmany < $len + 1 ) {
      $sub = substr( $number , $start , $howmany ) ;
      if ( exists( $associations->{$sub} ) ) {
	 $howmany++ ; #go further to the right until there is nof fit in the tab.
      }
      else {
	 $howmany-- ;
	 $sub = substr( $number , $start , $howmany ) ;
	 $sum += $associations->{$sub} ;
	 $start = $start + $howmany ;
	 $howmany = 1 ;
      }
   }
   $howmany-- ;
   $sub = substr( $number , $start , $howmany ) ;
   $sum += $associations->{$sub} ;
   return $sum ;
   }
}

sub arabToRoman {
   my $number = shift ;
   my $arabRomanAssos = shift ;
   my $num ;
   my $romanNum = "" ;
   while ( $number != 0 ) {
      if ( $number > 1000 ) {
	 $num = int( $number / 1000 ) * 1000 ; #convert , for example ,
#3498 to 3000 to better be able to look it up in the table
      }
      if ( ($number < 1000) && ($number >= 100) ) {
	 $num = int( $number / 100 ) * 100 ;
      }
      if ( ($number < 100 ) && ( $number >= 10 ) ) {
	 $num = int( $number / 10 ) * 10 ;
      }
      if ( $number < 10 ) {
	 $num = $number ;
      }
      my $asso = $arabRomanAssos->{$num} ;
      $romanNum .= $asso ;
      $number -= $num ;
   }
   return $romanNum ;
}

my %roman_To_Arab = (
      "M" => 1000 ,
      "MM" => 2000 , 
      "MMM" => 3000 , 
      "C"   => 100 ,
      "CC" => 200 ,
      "CCC" => 300 , 
      "CD" => 400 , 
      "D" => 500 , 
      "DC" => 600 , 
      "DCC" => 700 , 
      "DCCC" => 800 ,
      "CM" => 900 ,
      "X" => 10 , 
      "XX" => 20 , 
      "XXX" => 30 , 
      "XL" => 40 , 
      "L" => 50 , 
      "LX" => 60 ,
      "LXX" => 70 , 
      "LXXX" => 80 , 
      "XC" => 90 ,
      "I" => 1 , 
      "II" => 2 , 
      "III" => 3 , 
      "IV" => 4 , 
      "V" => 5 , 
      "VI" => 6 , 
      "VII" => 7 , 
      "VIII" => 8 ,
      "IX" => 9 
) ;
my %arab_To_Roman ;
while ( my ( $key , $value ) = each( %roman_To_Arab ) ) {
   $arab_To_Roman{ $value } = $key ;
}
say "Enter a 2 - term string in Roman numerals!" ;
my $line = <STDIN> ;
chomp $line ;
my $result ;
my ( $firstExpr , $operator , $secondExpr ) = split( /\s/ , $line ) ;
my $firstTerm = romanToArab( $firstExpr, \%roman_To_Arab ) ;
my $secondTerm = romanToArab( $secondExpr, \%roman_To_Arab ) ;
if ( $operator eq "+" ) {
   my $sum = $firstTerm + $secondTerm ;
   if ( $sum > 3999 ) {
      $result = "non potest" ;
   }
   else {
      $result = arabToRoman( $sum , \%arab_To_Roman ) ;
   }
}
if ( $operator eq "-" ) {
   my $difference = $firstTerm - $secondTerm ;
   if ( $difference < 0 ) {
      $result = "non potest" ;
   }
   if ( $difference == 0 ) {
      $result = "nulla" ;
   }
   if ( $difference > 0 ) {
      $result = arabToRoman( $difference , \%arab_To_Roman ) ;
   }
}
if ( $operator eq "*" ) {
   my $product = $firstTerm * $secondTerm ;
   if ( $product > 3999 ) {
      $result = "non potest" ;
   }
   else {
      $result = arabToRoman( $product , \%arab_To_Roman ) ;
   }
}
if ( $operator eq "/" ) {
   my $fraction = $firstTerm / $secondTerm ;
   if ( floor( $fraction ) != $fraction ) {
      $result = "non potest" ;
   }
   else {
      $result = arabToRoman( $fraction , \%arab_To_Roman ) ;
   }
}
if ( $operator eq "**" ) {
   my $potence = $firstTerm ** $secondTerm ;
   if ( $potence > 3999 ) {
      $result = "non potest" ;
   }
   else {
      $result = arabToRoman( $potence , \%arab_To_Roman ) ;
   }
}
say ( $line . " = " . $result ) ;
