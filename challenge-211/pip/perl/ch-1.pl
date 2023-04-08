#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #211 - Pip Stuart
# Task1: Toeplitz Matrix:  Submitted by: Mohammad S Anwar;  You are given a matrix m x n. Write a script to find out if the given matrix is Toeplitz Matrix.
#   A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.
# Example1:
#   In-put: @matrix = [ [4, 3, 2, 1],
#                       [5, 4, 3, 2],
#                       [6, 5, 4, 3], ]
#   Output:  true
# Example2:
#   In-put: @matrix = [ [1, 2, 3],
#                       [3, 2, 1], ]
#   Output: false
use strict;use warnings;use utf8;use v5.12;my $d8VS='N48M8DlW';
sub TpzM {my $mtrx = shift(@_);my $tplz = 1; # below eval string that looks like it's exclusively a 2D matrix array-ref of just comma-separated integerz
  if (ref($mtrx) ne 'ARRAY' && $mtrx =~ /^\s*\[\s*(\[\s*(\d+\s*,?\s*)+\]\s*,?\s*)+\]\s*$/     ) { $mtrx = eval($mtrx); }
  my $enen = @{$mtrx};    my   $emem = @{$mtrx->[0]}   ;
  for (1 ..  $enen - 2) { my   $edge =   $mtrx->[$_][0];my $roww = $_;my $colm =  0; if ($tplz) { # loop left-side diagonals but not bottom corner
      while ($roww <  $enen && $colm <   $emem   ) {#say "edge:$edge $mtrx->[$roww][$colm]:mtrx->roww,colm;";
        if  ($edge != $mtrx->[ $roww++][ $colm++]) { $tplz = 0;last; } } } }
  for (0 ..  $emem - 2) { my   $edge =   $mtrx->[0][$_];my $roww =  0;my $colm = $_; if ($tplz) { # loop  top-side diagonals but not right  corner
      while ($roww <  $enen && $colm <   $emem   ) {#say "edge:$edge $mtrx->[$roww][$colm]:mtrx->roww,colm;";
        if  ($edge != $mtrx->[ $roww++][ $colm++]) { $tplz = 0;last; } } } }
  print '[ ';my $fnif = 1; # set FirstNoIndentFlag;
  for (@{$mtrx}) { if ($fnif) { $fnif = 0; } else { print "\n  "; }
    printf("[%-10s],", join(', ',@{$_}) ); }
  say  " ] => $tplz;";
  return(     $tplz );
}
if    (@ARGV) {
  TpzM(@ARGV);
} else {
  TpzM([ [4, 3, 2, 1],
         [5, 4, 3, 2],
         [6, 5, 4, 3], ]); # => 1;
  TpzM([ [1, 2, 3   ],
         [3, 2, 1   ], ]); # => 0;
}
