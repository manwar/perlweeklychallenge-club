#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #207 - Pip Stuart
# Task1: Keyboard Word:  Submitted by: Mohammad S Anwar;  You are given an array of words.
#   Write a script to print all the words in the given array that can be types using alphabet on only one row of the keyboard.
#   Let us assume the keys are arranged as below:
#     Row1: qwertyuiop
#     Row2: asdfghjkl
#     Row3: zxcvbnm
# Example1:
#   In-put: @words = ("Hello","Alaska","Dad","Peace")
#   Output:          (        "Alaska","Dad"        )
# Example2:
#   In-put: @words = ("OMG","Bye")
#   Output:          (           )
use strict;use warnings;use utf8;use v5.12;my $d8VS='N38LGYRO';
sub KbWd {my @wrdz = @_;my @rwdz = ();my @rowz = ({}, {}, {});
  for (split('', 'qwertyuiop')) { $rowz[0]{$_} = 1; }
  for (split('', 'asdfghjkl' )) { $rowz[1]{$_} = 1; }
  for (split('', 'zxcvbnm'   )) { $rowz[2]{$_} = 1; }
  for (@wrdz) {my @lcwd = split('', lc($_));my   $airf = 0;
    for my $rown (0..2) {
      if     ( exists($rowz[$rown]{$lcwd[0]})) { $airf = 1;
        for my $letr (@lcwd) { # loop thru all of @LowerCasedWorD
          if (!exists($rowz[$rown]{$letr   })) { $airf = 0; last; }
        } # clear AllInRowFlag if any letter is not in the same row
      }
    }
    if ($airf) { push(@rwdz, $_); }
  }
  printf(             "(\"%s\") => ", join('","', @wrdz));
  if (@rwdz) { printf("(\"%s\");\n" , join('","', @rwdz)); }
  else       { say "();"; }
  return(@rwdz);
}
if    (@ARGV) {
  KbWd(@ARGV);
} else {
  KbWd("Hello","Alaska","Dad","Peace"); # => ("Alaska","Dad");
  KbWd("OMG","Bye"                   ); # => ("");
}
