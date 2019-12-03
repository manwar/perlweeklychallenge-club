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

my %code_to_letter = invert_hash( \%morsecode ) ;

sub invert_hash {
  my $code = shift ;
  my %code_to_letter ;
  while ( (my $letter , my $morse) = each %{$code} ) {
      $code_to_letter{ $morse } = $letter ;
  }
  return %code_to_letter ;
}

sub letter_decode {
  my $letter = shift ;
  my $code = shift ;
  my $morseletter ;
  if ( $letter =~ /0/ ) {
      my @codesigns = split( /0/ , $letter ) ;
      for my $sign ( @codesigns ) {
    if ( $sign eq "111" ) {
        $morseletter .= '-' ;
    }
    else {
        $morseletter .= '.' ;
    }
      }
  }
  else {
      if ( $letter eq "111" ) {
    $morseletter = '-' ;
      }
      else {
    $morseletter = '.' ;
      }
  }
  return ${$code}{ $morseletter } ;
}

sub word_decode {
  my $word = shift ;
  my @decoded ;
  if ( $word =~ /0{3,4}/ ) {#word with more than 1 letter
      my @letters = split ( /000|0000/, $word ) ;
      for my $letter ( @letters ) {
    push( @decoded , letter_decode( $letter, \%code_to_letter ) ) ;
      }
  }
  else { #word with just 1 letter
      push( @decoded, letter_decode( $word , \%code_to_letter ) ) ;
  }
  if ( $#decoded == 1 ) {
      return $decoded[0] ;
  }
  else {
      return join( '' , @decoded ) ;
  }
}

sub line_decode {
  my $line = shift ;
  my @decoded ;
  if ( $line =~ /0{5,7}/ ) {#allow for faulty separators, more than 1 word
      my @words = split ( /00000|000000|0000000/, $line ) ;
      foreach my $word ( @words ) {
    push ( @decoded , word_decode( $word ) ) ;
      }
  }
  else { #line consists of just 1 word
      return word_decode( $line ) ;
  }
  return join( " ", @decoded ) ;
}

print line_decode( "1110100000010111" ) . "\n" ;
