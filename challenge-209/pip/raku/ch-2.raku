#!/usr/bin/env raku
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #209 - Pip Stuart
# Task2: Merge Account:  Submitted by: Mohammad S Anwar;  You are given an array of accounts i.e. name with list of email addresses.
#   Write a script to merge the accounts where possible. The accounts can only be merged if they have at least one email address in common.
# Example1:
#   In-put: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
#                         ["B", "b1@b.com"],
#                         ["A", "a3@a.com", "a1@a.com"] ]
#   Output:             [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
#                         ["B", "b1@b.com"] ]
# Example2:
#   In-put: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
#                         ["B", "b1@b.com"],
#                         ["A", "a3@a.com"],
#                         ["B", "b2@b.com", "b1@b.com"] ]
#   Output:             [ ["A", "a1@a.com", "a2@a.com"],
#                         ["A", "a3@a.com"],
#                         ["B", "b1@b.com", "b2@b.com"] ]
# Last date to submit the solution 23:59 (UK Time) Sunday 26th March 2023.
use v6;my $d8VS='N3PM9779';
sub MrgA { my @argv = @_;my $actz = []; my $outp = [];
  while   (   @argv.elems) {$actz.push(shift(@argv)); }
  for          ( 0 .. @($actz       ).elems - 1 ) -> $andx { my $cmnf = 0;
    for        ( 0 .. @($outp       ).elems - 1 ) -> $ondx { # loop thru outp for any aref matching actz->[$andx][0] with same group name (A or B)
      if  ($actz[$andx][0] eq $outp[$ondx][  0] )          { my %emlz = ();
        for    ( 1 .. @($actz[$andx]).elems - 1 ) -> $aend { %emlz{ $actz[$andx][$aend]} = 1;
          for  ( 1 .. @($outp[$ondx]).elems - 1 ) -> $oend {
            if ($actz[$andx][$aend] eq  $outp[$ondx][$oend]) {  $cmnf = 1; last; } }
        };  if ($cmnf                           )          {
          for  ( 1 .. @($outp[$ondx]).elems - 1 ) -> $oend { %emlz{ $outp[$ondx][$oend]} = 1; } # save the output e-mails in the hash too...
          for  ( 1 .. @($outp[$ondx]).elems - 1 ) -> $oend { pop( @($outp[$ondx]       )   ); } #   ... before popping them all off then ...
          for  (sort(keys(%emlz))               ) -> $emal { push(@($outp[$ondx]       ), $emal ); } } } # ... add both orig accounts && matching output ones
    };  unless ($cmnf                           )          { push(@($outp              ),    [] ); # can't just push orig actz arefz since outp needs diff
      for      ( 0 .. @($actz[$andx]).elems - 1 ) -> $aall { push(@($outp[  *-1]       ), $actz[$andx][$aall]); } } }
  printf(           "[ ['%s']", join("', '", @($actz[ 0]))) if (@($actz).elems);
  if    (     @($actz).elems > 1) {   say   ',';
    for (1 .. @($actz).elems - 1) {
      printf(       "  ['%s']", join("', '", @($actz[$_])));
      say                    ','  if (  $_ < @($actz).elems - 1   ); }
  };  printf( " ] => [ ['%s']", join("', '", @($outp[ 0]))) if (@($outp).elems);
  if    (     @($outp).elems > 1) {   say   ',';
    for (1 .. @($outp).elems - 1) {   print ' ' x 31;
      printf( "        ['%s']", join("', '", @($outp[$_])));
      say                    ','  if (  $_ < @($outp).elems - 1   ); }
  };  say     " ];";
  return($outp); }
if    (@*ARGS) { say "!*Eror*! This code doesn't accept arguments. Please edit the source to specify an anonymous array of anonymous arrays as input.";
# MrgA(@*ARGS);
} else { # I switched all the strings to single-quoted so that the at-signs @ wouldn't need escaping or try to interpolate as arrays.
  MrgA( [ ['A', 'a1@a.com', 'a2@a.com'],
          ['B', 'b1@b.com'],
          ['A', 'a3@a.com', 'a1@a.com'] ] ); # => [ ['A', 'a1@a.com', 'a2@a.com', 'a3@a.com'],
                                             #      ['B', 'b1@b.com'] ];
  MrgA( [ ['A', 'a1@a.com', 'a2@a.com'],
          ['B', 'b1@b.com'],
          ['A', 'a3@a.com'],
          ['B', 'b2@b.com', 'b1@b.com'] ] ); # => [ ['A', 'a1@a.com', 'a2@a.com'],
                                             #      ['B', 'b1@b.com', 'b2@b.com'], # maybe supposed to re-order all A groups together before all B groups...
                                             #      ['A', 'a3@a.com'] ];           #   ... but I think my output is close enough preserving input  group order;
}
