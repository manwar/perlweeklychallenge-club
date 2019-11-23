#!/usr/bin/perl ;
use strict ;
use warnings ;

my %morsecode = ("A" => "._" , "B" => "-...", "C" => "-.-." ,
                "D" => "-..", "E" => "." , "F" => "..-." ,
        "G" => "--.", "H" => "....", "I" => ".." ,
        "J" => ".---", "K" => "-.-", "L" => ".-.." ,
        "M" => "--", "N" => "-." , "O" => "---" ,
        "P" => ".--." , "Q" => "--.-", "R" => ".-.",
        "S" => "..." , "T" => "-" , "U" => "..-",
        "V" => "...-" , "W" => ".--", "X" => "-..-" ,
        "Y" => "-.--" , "Z" => "--..", "1" => ".----",
        "2" => "..---", "3" => "...--", "4" => "....-",
        "5" => ".....", "6" => "-....", "7" => "--...",
        "8" => "---..", "9" => "----.", "0" => "-----",
        "." => ".-.-.-" , "," => "--..--" , "?" => "..--..",
        "!" => "-.-.--", "/" => "-..-.", "(" => "-.--." ,
        ")" => "-.--.-", ":" => "---...", ";" => "-.-.-.",
        "=" => "-...-", "+" => ".-.-." , "-" => "-....-",
        "_" => "..--.-", '$'=> "...-..-" , "@" => ".--.-.") ;

sub letter_encode { #encode 1 letter digitally
  my $letter = shift ;
  my $code = shift ;
  my $morseletter = ${$code}{ uc $letter } ;
  my @codeparts ;
  foreach my $sign ( split( // , $morseletter ) ) {
      if ( $sign eq '-' ) {
    push ( @codeparts , "111" ) ;
      }
      else {
    push ( @codeparts , "1" ) ;
      }
  }
  return join( '0' , @codeparts ) ;
}

sub word_encode {
  my $word = shift ;
  my @codedparts ;
  for my $letter ( split (// , $word) ) {
      push( @codedparts, letter_encode( $letter, \%morsecode ) ) ;
  }
  return join( "000" , @codedparts ) ;
}

sub line_encode {
  my $line = shift ;
  if ( $line !~ /\s/ ) {
      return ; #it's no usual line with at least one space
  }
  else {
      my @encoded ;
      my @words = split( /\s+/ , $line ) ;
      foreach my $word ( @words ) {
    push( @encoded, word_encode( $word ) ) ;
      }
      return join( "0000000" , @encoded ) ;
  }
}

print line_encode( "This is really interesting" ) . "\n" ;

