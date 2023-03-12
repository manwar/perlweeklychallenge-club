#!/usr/bin/env raku
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
use v6;my $d8VS='N39L7wLC';
sub KbWd {my @wrdz = @_;my @rwdz = ();my @rowz = ({}, {}, {});
  for (split('', 'qwertyuiop', :skip-empty)) { @rowz[0]{$_} = 1; }
  for (split('', 'asdfghjkl' , :skip-empty)) { @rowz[1]{$_} = 1; }
  for (split('', 'zxcvbnm'   , :skip-empty)) { @rowz[2]{$_} = 1; }
  for (@wrdz) {my @lcwd = split('', lc($_), :skip-empty);my $airf = 0;
    for 0..2 -> $rown {
      if     (  @rowz[$rown]{@lcwd[0]}:exists ) { $airf = 1;
        for @lcwd -> $letr { # loop thru all of @LowerCasedWorD
          if (!(@rowz[$rown]{$letr   }:exists)) { $airf = 0; last; }
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
if    (@*ARGS) {
  KbWd(@*ARGS);
} else {
  KbWd("Hello","Alaska","Dad","Peace"); # => ("Alaska","Dad");
  KbWd("OMG","Bye"                   ); # => ("");
}
