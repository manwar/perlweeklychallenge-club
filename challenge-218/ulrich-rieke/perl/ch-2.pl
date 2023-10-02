#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

sub toggle_row {
  my $array = shift ;
  my $row = shift ;
  my @changed_array = @{$array} ;#dereference to preserve the original array!
  my @subarray = @{$changed_array[$row]} ;
  for my $i ( 0..scalar(@subarray) - 1 ) {
      if ( $subarray[ $i ] == 0 ) {
    $subarray[ $i ] = 1 ;
      }
      else {
    $subarray[ $i ] = 0 ;
      }
  }
  $changed_array[ $row ] = [ @subarray ] ;
  return @changed_array ;
}

sub toggle_column {
  my $array = shift ;
  my $column = shift ;
  my @changed_array ;
  for my $ar ( @{$array} ) {
      my @subarray = @{$ar} ;
      if ( $subarray[ $column ] == 0 ) {
    $subarray[ $column ] = 1 ;
      }
      else {
    $subarray[ $column ] = 0 ;
      }
      push @changed_array , [ @subarray ] ;
  }
  return @changed_array ;
}

sub find_index {
  my $searched = shift ;
  my $array = shift ;
  my $pos = 0 ;
  while ( $array->[$pos] != $searched ) {
      $pos++ ;
  }
  return $pos ;
}

sub to_binary_sum {
  my $array = shift ;
  my $sum = 0 ;
  for my $subarray( @{$array} ) {
      my $sublen = scalar( @{$subarray} ) ;
      for my $i (0..$sublen - 1 ) {
    $sum += 2 ** ($sublen - 1 - $i ) * $subarray->[ $i ] ;
      }
  }
  return $sum ;
}


say "Enter an m x n array of 0 and 1 only, blanks to separate!" ;
say "Enter end to end!" ;
my @matrix ;
my $line = <STDIN> ;
my $maximum ; #the maximum of all moves of a given matrix
chomp $line ;
while ( $line ne "end" ) {
  my @numbers = split( /\s/ , $line ) ;
  push @matrix, \@numbers ;
  $line = <STDIN> ;
  chomp $line ;
}
my $matrixlen = scalar( @matrix ) ;
my $rowlen = scalar( @{$matrix[0]}  ) ;
if ( $matrixlen == 1 ) {
  my @toggled = toggle_row( \@matrix , 0 ) ;
  say to_binary_sum( \@toggled ) ;
}
else {
  my @matrix_bin_sums ; #holds the binary row sums of all transformations of a
#given matrix
  my @all_maxima ; #holds the maxima of all transformations
  for my $r (0..$matrixlen - 1 ) {
      my @toggled = toggle_row( \@matrix , $r ) ;
      push @matrix_bin_sums , to_binary_sum( \@toggled ) ;
  }
  for my $c (0..$rowlen - 1) {
      my @toggled = toggle_column( \@matrix , $c ) ;
      push @matrix_bin_sums , to_binary_sum( \@toggled ) ;
  }
  $maximum = max(@matrix_bin_sums) ;
  push @all_maxima, $maximum ;
  if ( $maximum < to_binary_sum( \@matrix )) { #we don't improve on toggling
      say $maximum ;
  }
  else {
#we find the maximum binary sum which results from toggling every row and every
#column of a given matrix. Once we've got it, we reconstruct the matrix that
#produces that maximum. For that , we find the position of the maximum in the
#@matrix_bin_sums array. Since we toggle the rows first and the columns next, we
#can derive the matrix that produced the maximum. It becomes our new current matrix.
#We continue until the values of the maxima begin to fall. We then return the former
#greatest maximum
      my @current_matrix ;
      for my $ar ( @matrix ) { #we duplicate the start matrix to have a current
#matrix which we keep changing until the above condition is fulfilled
    push @current_matrix , $ar ;
      }
      while ( scalar( @all_maxima ) == 1 || $all_maxima[-1] > $all_maxima[ -2 ] ) {
    my $pos = find_index( $maximum , \@matrix_bin_sums ) ;
    my @toggled ;
    if ( $pos < $matrixlen ) {
        @toggled = toggle_row( \@current_matrix, $pos ) ;
    }
    else {
        @toggled = toggle_column( \@current_matrix, $pos - $matrixlen ) ;
    }
    @current_matrix = ( ) ; #we must unset this variable to overwrite with the
#toggle position that produced the maximum
    @matrix_bin_sums = ( ) ; #new matrix , new binary row sums!
    for my $ar( @toggled ) {
        push @current_matrix , $ar ;
    }
    for my $r (0..$matrixlen - 1 ) {
        @toggled = toggle_row( \@current_matrix , $r ) ;
        push @matrix_bin_sums, to_binary_sum( \@toggled ) ;
    }
    for my $c (0..$rowlen - 1 ) {
        @toggled = toggle_column( \@current_matrix, $c ) ;
        push @matrix_bin_sums , to_binary_sum( \@toggled ) ;
    }
    $maximum = max( @matrix_bin_sums ) ;
    push @all_maxima , $maximum ;
      }
      say $all_maxima[-2] ;
  }
}
