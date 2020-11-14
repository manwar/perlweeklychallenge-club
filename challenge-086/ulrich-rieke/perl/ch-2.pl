#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw( all ) ;

#in order to use the script for different sudokus I add this function
#and do not add a __DATA__ block at the end of the code
sub enterPuzzle {
  my @puzzle ;
  say "Enter numbers or underscores!" ;
  for my $row (0..8 ) {
      my $line = <STDIN> ;
      chomp $line ;
      while ( $line !~ /[_1-9]{9}/ ) {
    say "Not a valid entry! Enter again!" ;
    $line = <STDIN> ;
    chomp $line ;
      }
      push @puzzle ,  $line ;
  }
  return @puzzle ;
}

#check if a row is valid ; count the occurrences of digits in a row
sub isRowValid {
  my $sudoku = shift ;
  my $row = shift ;
  my %rowFreq ;
  for my $i ( 0 .. 8 ) {
      my $val = substr( $sudoku->[ $row ] , $i , 1) ;
      if ( $val =~ /\d/ ) {
    $rowFreq{ $val }++ ;
      }
  }
  return all { $_ == 1 } values %rowFreq ;
}

sub printArray {
  my $array = shift ;
  for my $i ( 0 .. 8 ) {
      print "[ " ;
      map { print "$_ " } split (// , $array->[ $i ] ) ;
      print "]\n" ;
  }
}

#check if colums is valid, count the occurrences of digits in a column
sub isColumnValid {
  my $sudoku = shift ;
  my $column = shift ;
  my %columnFreq ;
  for my $i (0 .. 8 ) {
      my $val = substr( $sudoku->[ $i ] , $column , 1 ) ;
      if ( $val =~ /\d/ ) {
    $columnFreq{ $val }++ ;
      }
  }
  return all { $_ == 1 } values %columnFreq ;
}

#find the ranges of rows or columns in a 3 x 3 block
sub findRange {
  my $num = shift ;
  my @numrange ;
  if ( $num <= 2 ) {
      @numrange = (0 , 1 , 2 ) ;
  }
  if ( $num > 2 and $num <= 5 ) {
      @numrange = ( 3 , 4 , 5 ) ;
  }
  if ( $num > 5 ) {
      @numrange = ( 6 , 7 , 8 ) ;
  }
  return @numrange ;
}

#for any given row and colums check if the number of occurrences of digits
#in that block is 1
sub isBlockValid {
  my $sudoku = shift ;
  my $row = shift ;
  my $col = shift ;
  my %numFreq ;
  my @rowranges = findRange( $row ) ;
  my @columnranges = findRange( $col ) ;
  for my $r ( @rowranges ) {
      for my $c ( @columnranges ) {
    my $val = substr( $sudoku->[ $r ] , $c , 1 ) ;
    if ( $val =~ /\d/ ) {
        $numFreq{ $val }++ ;
    }
      }
  }
  return all { $_ == 1 } values %numFreq ;
}

sub conditionFulfilled {
  my ( $sudoku, $row , $col ) = @_ ;
  return (isRowValid( $sudoku , $row ) and isColumnValid( $sudoku, $col)
    and isBlockValid( $sudoku, $row , $col )) ;
}

my @puzzle = enterPuzzle( ) ;
printArray(\@puzzle ) ;
say "Everything entered correctly ? (Yy)es or (Nn)o ?" ;
my $answer = <STDIN> ;
chomp $answer ;
while ( $answer =~ /[nN]/ ) {
  @puzzle = enterPuzzle( ) ;
  printArray (\@puzzle) ;
  say "Everything entered correctly ? (Yy)es or (Nn)o ?" ;
  $answer = <STDIN> ;
  chomp $answer ;
}
my @openpositions ; #finds the occurrences of all underscores in the sudoku
for my $currentRow( 0..8 ) {
  my $pos = -1 ;
  while ( ( $pos = index( $puzzle[ $currentRow ] , '_' , $pos )) != -1 ) {
      push @openpositions , [ $currentRow , $pos] ;
      $pos++ ;
  }
}
my $len = scalar @openpositions ;
my $current = 0 ;
#main part of the script: cycle through all the positions of underscores
#keep adding 1 at a given position until the number is valid and fulfills
#all conditions of sudoku. If this is not the case or adding 1 leads to
#a number > 9 , enter '_' at this point and go back to the previous
#underscore position. Keep adding 1 at this position until it's valid
#again. Then go forward again. Repeat this again and again until a number
#for the last underscore in @openpositions has been found
#so this is a kind of brute force approach with backtracking!
LOOP: while ( $current < $len ) {
  my $theRow = $openpositions[ $current ]->[0] ;
  my $theCol = $openpositions[ $current ]->[1] ;
  my $char = substr($puzzle[$theRow] , $theCol , 1 ) ;
  if ( $char =~ /\d/ ) {
      $char++ ;
      if ( $char > 9 ) {
    substr( $puzzle[$theRow] , $theCol , 1 ) = '_' ;
    $current-- ;
    next LOOP ;
      }
  }
  else {
      $char = 1 ;
  }
  substr( $puzzle[$theRow] , $theCol , 1 ) = $char ;
  while ( not ( conditionFulfilled (\@puzzle , $theRow , $theCol ) ) ) {
      $char++ ;
      if ( $char > 9 ) {
    substr( $puzzle[$theRow] , $theCol , 1 ) = '_' ;
    $current-- ;
    next LOOP ;
      }
      else {
    substr( $puzzle[$theRow] , $theCol , 1 ) = $char ;
      }
  }
  $current++ ;
}
printArray (\@puzzle ) ;
