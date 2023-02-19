#!/usr/bin/env raku
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
use v6;use MONKEY-SEE-NO-EVAL;my $d8VS='N2GL09JB';
sub Rshp {my $mtrx=shift(@_);my $rrow=shift(@_);my $rclm=shift(@_);my @m1mn=();my $rsar=0; # ReShape ArrayRef just zero if haven't reshaped yet;
  if    ( $mtrx.WHAT.^name ne 'List' && $mtrx ~~ /<[\[\d\,\]\s]>+/) { $mtrx=EVAL("$mtrx"); } # take '[[1,2],[3,4]]' string && EVAL it into matrix array-ref;
  for   (@$mtrx) { say '[ ' ~ "@$_[]" ~ ' ]';
    for  @$_ -> $elem  { @m1mn.push($elem); } } # make new input matrix that's just 1 row x (m*n) columns flattened together;
  print "\$r = $rrow, \$c = $rclm => ";
  if (@m1mn.elems ==  $rrow*$rclm) {$rsar=          [] ; # make sure total number of elems is same as new rows x columns target dimensions;
    for   0..$rrow-1 -> $rowc {    @$rsar     .push([]);
      for 0..$rclm-1 -> $clmc {    @$rsar[*-1].push(@m1mn[$rowc*$rclm+$clmc]); } } }
  if             (!$rsar) { say    "$rsar;"; } else { my $fncf=1;print '[ '; # set FirstNoCommaFlag;
    for          (@$rsar) { if ($fncf) { $fncf=0; } else {       print ', '; }
      print            '[ ' ~ "@$_[]" ~ ' ]'; }
    say ' ];'; }
  return(          $rsar );
}
if    (@*ARGS) {
  Rshp(@*ARGS);
} else { my $ilst; # have to pass Input LiST already in scalar since it seems function call syntax flattens embedded lists into the argument list;
  $ilst=((1,2  ),(3,4  ));Rshp($ilst,1,4); # => [[1,2 , 3,4      ]];
  $ilst=((1,2,3),(4,5,6));Rshp($ilst,3,2); # => [[1,2],[3,4],[5,6]];
  $ilst=((1,2  ),       );Rshp($ilst,3,2); # =>   0                ;
}
