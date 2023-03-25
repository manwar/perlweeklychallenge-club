#!/usr/bin/perl
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
use strict;use warnings;use utf8;use v5.12;my $d8VS='N3PM8qQm';
sub MrgA { my    $actz = shift(@_);    my $outp =[];
  for   my $andx (0 .. @{$actz} - 1) { my $cmnf = 0;
    for my $ondx (0 .. @{$outp} - 1) { # loop thru outp for any aref matching actz->[$andx][0] with same group name (A or B)
      if  ($actz->[$andx][0] eq $outp->[$ondx][   0]) {my %emlz = ();
        for   my $aend ( 1 .. @{$actz->[$andx]} - 1 ) { $emlz{ $actz->[$andx][$aend]} = 1;
          for my $oend ( 1 .. @{$outp->[$ondx]} - 1 ) {
            if  ($actz->[$andx][$aend] eq $outp->[$ondx][$oend]) { $cmnf = 1; last; } }
        };  if  ($cmnf                              ) {
          for my $oend ( 1 .. @{$outp->[$ondx]} - 1 ) { $emlz{ $outp->[$ondx][$oend]} = 1; } # save the output e-mails in the hash too...
          for my $oend ( 1 .. @{$outp->[$ondx]} - 1 ) { pop( @{$outp->[$ondx]       }   ); } #   ... before popping them all off then ...
          for my $emal (sort(keys(%emlz))           ) { push(@{$outp->[$ondx]       }, $emal ); } } } # ... add both original accounts && matching output ones
    };  unless  ($cmnf                              ) { push(@{$outp                },    [] ); # can't just push orig actz array refz since outp needs diff
      for     my $aall ( 0 .. @{$actz->[$andx]} - 1 ) { push(@{$outp->[   -1]       }, $actz->[$andx][$aall]); } } }
  printf(           "[ ['%s']", join("', '", @{$actz->[ 0]})) if (@{$actz});
  if    (     @{$actz} > 1) {   say   ',';
    for (1 .. @{$actz} - 1) {
      printf(       "  ['%s']", join("', '", @{$actz->[$_]}));
      say                    ','  if (  $_ < @{$actz} - 1   ); }
  };  printf( " ] => [ ['%s']", join("', '", @{$outp->[ 0]})) if (@{$outp});
  if    (     @{$outp} > 1) {   say   ',';
    for (1 .. @{$outp} - 1) {   print ' ' x 31;
      printf( "        ['%s']", join("', '", @{$outp->[$_]}));
      say                    ','  if (  $_ < @{$outp} - 1   ); }
  };  say     " ];";
  return($outp); }
if    (@ARGV) { say "!*Eror*! This code doesn't accept arguments. Please edit the source to specify an anonymous array of anonymous arrays as input.";
# MrgA(@ARGV);
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
