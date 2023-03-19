#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #208 - Pip Stuart
# Task1: Minimum Index Sum:  Submitted by: Mohammad S Anwar;  You are given two arrays of strings.
#   Write a script to find out all common strings in the given two arrays with minimum index sum. If no common strings found returns an empty list.
# Example1:
#   In-put: @list1 = ("Perl", "Raku", "Love")
#           @list2 = ("Raku", "Perl", "Hate")
#   Output: ("Perl", "Raku")
#     There are two common strings "Perl" and "Raku".
#       Index sum of "Perl": 0 + 1 = 1
#       Index sum of "Raku": 1 + 0 = 1
# Example2:
#   In-put: @list1 = ("A", "B", "C")
#           @list2 = ("D", "E", "F")
#   Output: ()
#     No common string found, so no result.
# Example3:
#   In-put: @list1 = ("A", "B", "C")
#           @list2 = ("C", "A", "B")
#   Output: ("A")
#     There are three common strings "A", "B" and "C".
#       Index sum of "A": 0 + 1 = 1
#       Index sum of "B": 1 + 2 = 3
#       Index sum of "C": 2 + 0 = 2
use strict;use warnings;use utf8;use v5.12;my $d8VS='N3JM5MJp';
sub MInS {my @lst2 = @_;my @lst1 = ();my @mins = ();my @nsmz = ();my %ndxs = ();
  while ($lst2[0] ne ';') {
    push(@lst1,             shift(@lst2));
  }; if ($lst2[0] eq ';') { shift(@lst2) ; } # remove the semicolon separator
  for   my $ndx1 (0..$#lst1) {
    for my $ndx2 (0..$#lst2) {
      if ($lst1[$ndx1] eq $lst2[$ndx2]) {
        push(@{$ndxs{ $ndx1 + $ndx2 }}, $lst1[$ndx1]);
      }
    }
  }
  @nsmz = sort { $a <=> $b } keys(%ndxs);
  @mins = @{$ndxs{$nsmz[0]}} if  (@nsmz);
  printf(                "(\"%s\") ,\n", join('","', @lst1));
  printf(                "(\"%s\") => ", join('","', @lst2));
  if    (@mins) { printf("(\"%s\");\n" , join('","', @mins)); }
  else          { say    "();"; }
  return(@mins);
}
if    (@ARGV) {
  MInS(@ARGV);
} else {
  MInS("Perl","Raku","Love",";",   # I've decided to use a single semicolon to separate the 2 input lists of strings.
       "Raku","Perl","Hate"     ); # => ("Perl","Raku");
  MInS("A","B","C",";",
       "D","E","F"              ); # => ();
  MInS("A","B","C",";",
       "C","A","B"              ); # => ("A");
}
