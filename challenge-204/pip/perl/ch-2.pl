#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #204 - Pip Stuart
# Task2: Reshape Matrix:  Submitted by: Mohammad S Anwar;  You are given a matrix (m x n) and two integers (r) and (c).
#   Write a script to reshape the given matrix in form (r x c) with the original value in the given matrix. If you can’t reshape print 0.
# Example1:
#   In-put: [ 1 2 ]
#           [ 3 4 ]
#           $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
#           $r = 1
#           $c = 4
#   Output: [ 1 2 3 4 ]
# Example2:
#   In-put: [ 1 2 3 ]
#           [ 4 5 6 ]
#           $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
#           $r = 3
#           $c = 2
#   Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
#           [ 1 2 ]
#           [ 3 4 ]
#           [ 5 6 ]
# Example3:
#   In-put: [ 1 2 ]
#           $matrix = [ [ 1, 2 ] ]
#           $r = 3
#           $c = 2
#   Output: 0
# Last date to submit the solution 23:59 (UK Time) Sunday 19th February 2023.
use strict;use warnings;use utf8;use v5.12;my $d8VS='N2GL00px';
sub Rshp {my $mtrx=shift(@_);my $rrow=shift(@_);my $rclm=shift(@_);my @m1mn=();my $rsar=0; # ReShape ArrayRef just zero if haven't reshaped yet;
  if    (ref($mtrx) ne 'ARRAY' && $mtrx =~ /^[\[0-9,\] ]+$/) { $mtrx=eval("$mtrx"); } # take '[[1,2],[3,4]]' string scalar && eval it into matrix array-ref;
  for            (@{$mtrx}) { say '[ ' . "@{$_}" . ' ]';
    for my $elem (@{$_   }) { push(@m1mn,$elem); } } # make new input matrix that's just 1 row x (m*n) columns flattened together;
  print "\$r = $rrow, \$c = $rclm => ";
  if (@m1mn == $rrow*$rclm) {            $rsar =[] ; # make sure total number of elems is same as new rows x columns target dimensions;
    for   my $rowc (0..$rrow-1) { push(@{$rsar},[]);
      for my $clmc (0..$rclm-1) { push(@{$rsar->[-1]},$m1mn[$rowc*$rclm+$clmc]); } } }
  if             ( !$rsar ) { say "$rsar;"; } else { my $fncf=1;print '[ '; # set FirstNoCommaFlag;
    for          (@{$rsar}) { if ($fncf) { $fncf=0; } else { print ', '; }
      print                       '[ ' . "@{$_}" . ' ]'; }
    say ' ];'; }
  return(           $rsar );
}
if    (@ARGV) {
  Rshp(@ARGV);
} else {
  Rshp([[1,2  ],[3,4  ]],1,4); # => [[1,2 , 3,4      ]];
  Rshp([[1,2,3],[4,5,6]],3,2); # => [[1,2],[3,4],[5,6]];
  Rshp([[1,2  ]        ],3,2); # =>   0                ;
}
