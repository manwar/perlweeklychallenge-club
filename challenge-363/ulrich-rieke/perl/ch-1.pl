#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub analyze_string {
   my $sentence = shift ;
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
                    20 => "twenty" ) ;
   my $vowels = "AEIOUaeiou" ;
   my $vowelcount = 0 ;
   my $consocount = 0 ;
   my @allWords = split( /\s/ , $sentence ) ;
   for my $letter( split( // , $allWords[0] ) ) {
      if (index( $vowels , $letter) != -1 ) {
         $vowelcount++ ;
      }
      else {
         $consocount++ ;
      }
   }
   if ($conversions{$vowelcount} eq $allWords[2] && $conversions{$consocount} eq 
      $allWords[5] ) {
      return "true" ;
   }
   else {
      return "false" ;
   }
}

say analyze_string( "aa - two vowels and zero consonants" ) ;
say analyze_string( "iv - one vowel and one consonant" ) ;
say analyze_string( "hello - three vowels and two consonants") ;
say analyze_string( "aeiou - five vowels and zero consonants" ) ;
say analyze_string( "aei - three vowels and zero consonants" ) ;
