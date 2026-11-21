#!/usr/bin/env perl

=pod

──────────────────────────────────────────────────────────────────────────────────────────────────────────────
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 400-2,
written by Robbie Hatley on Wed Nov 18, 2026.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────
PROBLEM DESCRIPTION:

Task 400-2: Minimum Genetic Mutation
Submitted by: Mohammad Sajid Anwar
You are given start and end gene string along with gene bank.
Write a script to return the minimum number of mutations required
to mutate from start to end gene. Return -1 if there is no such
mutation. A gene must be in a bank to make it a valid gene string.
A gene string can be represented by an 8-character long string,
with choices from ‘A’, ‘C’, ‘G’, and ‘T’.

(See "# INPUTS:" section below for examples.)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────
PROBLEM NOTES:

To solve this problem, I build non-repeating chains of genes such that each gene in a chain varies from the
previous in exactly one base pair. I start by making all 0-step chains (and there will always be exactly one,
which is the chain consisting of the starting gene only). For each number of steps, if a chain can be found
ending with the desired "end" gene, I return the chain length. Else if no chains can be made of the current
number-of-steps, I return -1. Else I stash my list of chains of current number-of-steps in an array of arrays
of chains, I increment number-of-steps, and I try again.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a comma-separated list of 3-or-more 8-character strings. Each string must
consist only of the characters ACGT. The first string is a "start gene". The second string is a "end gene".
All remaining strings taken together are a "gene bank". The "end gene" must also appear in the "gene bank".
For example:

./ch-2.pl 'AGCGATTT,ACGCATTT,ACGCATTT,AGCCATTT,ACCCATTT' 'ATGTCGAA,ATGCTGAA,ATGCCGAA,ATGCTGAA,GTACTGCA'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ────────────────────────────────────────────────────────────────────────────────────────────────────────────
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   use utf8::all;
   $"=', ';

   # Are two given gene sequences both 8 characters long and differ by exactly 1 character?
   sub db1 ( $g1 , $g2 ) {
      return false unless 8 == length $g1;
      return false unless 8 == length $g2;
      my $diffs = 0;
      for ( my $i = 0 ; $i < 8 ; ++$i ) {
         ++$diffs if substr($g1, $i, 1) ne substr($g2, $i, 1);
      }
      return (1 == $diffs);
   }

   # What number of mutations is needed to mutate one gene sequence to another?
   sub steps ( $aref ) {
      my @bank  = @{$aref};
      my $start = shift @bank;
      my $end   = shift @bank;
      # If end equals start, we're already done, so return (0, $start):
      return (0, $start) if $end eq $start;
      # Make an array of arrays of chains, with the inner array at index n containing chains of n steps:
      my @chains = ([[$start]]);
      # For each number of steps from 1 upward, make new non-repeating chains until we either find a chain
      # ending in $end, or we can no-longer make new chains:
      for ( my $steps = 1 ; 0 != scalar @{$chains[$steps-1]} ; ++$steps ) {
         # Push a new empty anonymous array to the end of @chains to hold chains of $steps steps:
         push @chains, [];
         # For each chain of length $steps-1, find all possible expansions:
         foreach my $chainref (@{$chains[$steps-1]}) {
            my @chain = @{$chainref};
            # Try each possible next step:
            TARGET: foreach my $target (@bank) {
               # Prevent going around in circles:
               SEQUENCE: foreach my $gene (@chain) {
                  next TARGET if $target eq $gene;
               }
               # Does the target differ from the last line of the chain by exactly 1 base pair?
               if ( db1($target, $chain[-1]) ) {
                  # If $target is equal to $end, we've found a solution, so return number-of-steps and chain:
                  if ( $target eq $end ) {
                     return ($steps, @chain, $end);
                  }
                  # Otherwise, make and stash a new chain:
                  else {
                     push @{$chains[$steps]}, [@chain, $target];
                  }
               }
            }
         }
      }
      return -1;
   }

   # Parse comma-separated lists of strings:
   sub parse_argv_1 ( @bash_args ) {
      my @args = ();
      foreach my $bash_arg (@bash_args) {
         push @args, [map {trim $_} split /,/, $bash_arg, -1];
      }
      return @args;
   }

# ────────────────────────────────────────────────────────────────────────────────────────────────────────────
# INPUTS:
my @arrays = @ARGV ? parse_argv_1(@ARGV) :
(
   ["AACCGGTT","AACCGGTA","AACCGCTA","AAACGGTA"                                                       ],#-1
   ["AACCGGTT","AACCGGAA","AACCGGTA","AACCGGAA","AACCGCTA","AACCCTAA","AACCGTAA"                      ],# 2
   ["AAAAAAAA","AAAAACCC","CAAAAAAA","CCAAAAAA","AAAAAAAC"                                            ],#-1
   ["GAAAAAAA","GCCCCCCC","GCAAAAAA","GCCAAAAA","GCCCAAAA","GCCCCAAA","GCCCCCAA","GCCCCCCA","GCCCCCCC"],# 7
   ["AACCGGTT","AACCGGTT","AACCGGTA"                                                                  ],# 0
);

# ────────────────────────────────────────────────────────────────────────────────────────────────────────────
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @bank  = @$aref;
   my $start = shift @bank;
   my $end   = shift @bank;
   my @chain = steps($aref);
   my $steps = shift @chain;
   if ( $steps < 0 ) {
      say "No mutation chain exists from $start to $end with bank (@bank).";
   }
   else {
      say "$steps steps were required to mutate $start to $end with bank (@bank):\n"
         ."@chain";
   }
}
