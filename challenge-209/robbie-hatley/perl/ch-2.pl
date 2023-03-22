#! /bin/perl -CSDA

=pod

This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。 麦藁雪、富士川町、山梨県。
=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|

  ----------------------------------------------------------------
  | Robbie Hatley's Perl soultion to The Weekly Challenge 209-2. |
  | Written Tue. Mar. 21, 2023, by Robbie Hatley.                |
  ----------------------------------------------------------------

PROBLEM DESCRIPTION:

Task 2: Merge Account
Submitted by: Mohammad S Anwar
You are given an array of accounts i.e. name with list of email addresses. Write a script to merge the accounts where
possible. The accounts can only be merged if they have at least one email address in common.
Example 1: Input:  [['A', 'a1@a.com', 'a2@a.com'] , ['B', 'b1@b.com'] , ['A', 'a3@a.com', 'a1@a.com']]
           Output: [['A', 'a1@a.com', 'a2@a.com', 'a3@a.com'], ['B', 'b1@b.com']]
Example 2: Input:  [['A', 'a1@a.com', 'a2@a.com'], ['B', 'b1@b.com'], ['A', 'a3@a.com'], ['B', 'b2@b.com', 'b1@b.com']]
           Output: [['A', 'a1@a.com', 'a2@a.com'], ['A', 'a3@a.com'], ['B', 'b1@b.com', 'b2@b.com']]

INPUT/OUTPUT NOTES:

Input is via built-in array of arrays of arrays, or by @ARGV. If using @ARGV, input should be a single argument
consisting of an array of arrays of arrays, in proper Perl syntax, with each email address surrounded by 'single quotes'
and with the entire array of arrays of arrays surrounded by "double quotes", like so:
"([['麦','se@gop.com','麦藁@雪.com'],['T','2@38.com'],['藁','麦藁@雪.com','b@a.com']],[['B','f@g.com'],['S','h@i.com']])"

Output is to STDOUT and will be each "raw" set of input arrays, followed by the "merged" set.

=cut

# PRELIMINARIES:

use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use List::Util 'uniqstr';
$" = ', ';

# DEFAULT INPUTS:

# Declare an Array of Arrays of Arrays called @aaa:
my @array = 
(
   [
      ['A', 'a1@a.com', 'a2@a.com'],
      ['B', 'b1@b.com'],
      ['A', 'a3@a.com', 'a1@a.com']
   ],
   [
      ['A', 'a1@a.com', 'a2@a.com'],
      ['B', 'b1@b.com'],
      ['A', 'a3@a.com'],
      ['B', 'b2@b.com', 'b1@b.com']
   ],
   [
      ['麦','se@gop.com','麦藁@雪.com'],
      ['T','2@38.com'],
      ['藁','麦藁@雪.com','b@a.com']
   ],
   [
      ['B','f@g.com'],['S','h@i.com']
   ]
);

# NON-DEFAULT INPUTS:

if (@ARGV) {@array = eval($ARGV[0])}

# MAIN BODY OF SCRIPT:

for my $set (@array){                          # Riffle through array of sets of accounts.
   my @accts;                                  # Make an array to hold merged accounts.
   my %emailhsh;                               # Hash of emails, keyed by email, value = account serial number.
   my $na = 0;                                 # Next Available account serial number.
   for (@{$set}){                              # For each account in this set.
      my @copy = @{$_};                        # Store a COPY of current account in @copy.
      my $alias = shift @copy;                 # Strip current account's alias from @copy and store separately.
      my $eater = undef;                       # No eater is defined for this account (yet).
      for my $email (@copy){                   # For each email address,
         if (defined $emailhsh{$email}){       # If current email is in use by another account,
            $eater = $emailhsh{$email};        # mark that account as being the eater of current account
            last;}}                            # and stop riffling through emails.
      if (defined $eater){                     # If this account is about to be eaten,
         for my $email (@copy){                # record each of this account's emails
            $emailhsh{$email} = $eater;}       # in %emailhsh as now belonging to the eater.
         my $ealias =                          # Strip eater's alias from left end of emails
            shift @{$accts[$eater]};           # and store in separate variable.
         push @{$accts[$eater]}, @copy;        # Paste copy of current account's emails onto eater's emails.
         @{$accts[$eater]}                     # Sort eater's emails
            = uniqstr sort @{$accts[$eater]};  # and remove duplicates.
         unshift @{$accts[$eater]}, $ealias;}  # Tack eater's alias back onto left end of eater's emails.
      else{                                    # If this account is NOT about to be eaten, store it as a new account.
         for my $email (@copy){                # Record the new account's emails in %emailhsh as belonging to
            $emailhsh{$email} = $na;}          # this new account, using Next Available serial number.
         unshift @copy, $alias;                # Tack alias back onto left end of emails.
         push @accts, \@copy;                  # Push ref to copy of current account onto @accts.
         ++$na;}}                              # Increment $na to Next Available serial number.
   say '';                                     # Start new announcement block.
   say "Accounts before merging:";             # Announce accounts before merging.
   say "(@{$_})" for @{$set};                  # Print original set of accounts.
   say "Accounts after merging:";              # Announce accounts after merging.
   say "(@{$_})" for @accts;}                  # Print merged set of accounts.