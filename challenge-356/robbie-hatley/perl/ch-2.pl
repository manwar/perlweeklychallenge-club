#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 356-2,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 356-2: Who Wins
Submitted by: Simon Green
It’s NFL playoff time. Since the 2020 season, seven teams from
each of the league’s two conferences (AFC and NFC) qualify for
the playoffs based on regular season winning percentage, with
a tie-breaking procedure if required. The top team in each
conference receives a first-round bye, automatically advancing
to the second round.

The following games are played. Some times the games are played
in a different order. To make things easier, assume the order
is always as below.

- Week 1: Wild card playoffs
  - Team 1 gets a bye
  - Game 1: Team 2 hosts Team 7
  - Game 2: Team 3 hosts Team 6
  - Game 3: Team 4 hosts Team 5
- Week 2: Divisional playoffs
  - Game 4: Team 1 hosts the third seeded winner from the
            previous week.
  - Game 5: The highest seeded winner from the previous week
            hosts the second seeded winner.
- Week 3: Conference final
  - Game 6: The highest seeded winner from the previous week
            hosts the other winner

You are given a six character string containing only H (home)
and A away which has the winner of each game. Which two teams
competed in the the conference final and who won?

Example #1:
Input:  $results = "HAHAHH"
Output: "Team 2 defeated Team 6"

Example #2:
Input:  $results = "HHHHHH"
Output: "Team 1 defeated Team 2"

Example #3:
Input:   $results = "HHHAHA"
Output: "Team 4 defeated Team 2"

Example #4:
Input:  $results = "HAHAAH"
Output: "Team 4 defeated Team 6"

Example #5:
Input: $results = "HAAHAA"
Output: "Team 5 defeated Team 1"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I make lists of winners sorted by seeds for each of the first two weeks..

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings of 6 [HA], in proper Perl syntax, like so:

./ch-2.pl '("AHAHAH", "HAHAHA")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use Switch;

   # Given a string $s of 6 [HA], which two NFL teams
   # played in the conference final and who won?
   sub seed ( $s ) {
      return (0,0) unless $s =~ m/^[HA]{6}$/;
      my @HA = split '', $s;
      my @w; # Winners.
      # Week 1:
      switch ($HA[0]) {
         case 'H' {push @w, 2}
         case 'A' {push @w, 7}
      }
      switch ($HA[1]) {
         case 'H' {push @w, 3}
         case 'A' {push @w, 6}
      }
      switch ($HA[2]) {
         case 'H' {push @w, 4}
         case 'A' {push @w, 5}
      }
      my @w1seeds = sort {$a<=>$b} @w[0..2];
      # Week 2:
      switch ($HA[3]) {
         case 'H' {push @w, 1}
         case 'A' {push @w, $w1seeds[2]}
      }
      switch ($HA[4]) {
         case 'H' {push @w, $w1seeds[0]}
         case 'A' {push @w, $w1seeds[1]}
      }
      my @w2seeds = sort {$a<=>$b} @w[3..4];
      # Week 3:
      my $first;  # Winning team.
      my $second; # Runner-up.
      switch ($HA[5]) {
         case 'H' {$first  = $w2seeds[0];
                   $second = $w2seeds[1]}
         case 'A' {$first  = $w2seeds[1];
                   $second = $w2seeds[0]}
      }
      return ($first, $second);
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("HAHAHH", "HHHHHH", "HHHAHA", "HAHAAH", "HAAHAA");

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   say "String = $string";
   my ($first, $second) = seed($string);
   say "Team $first defeated team $second.";
}
