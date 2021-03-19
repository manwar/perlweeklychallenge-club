#!/usr/bin/perl

# Perl Weekly Challenge - 104
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-104/#TASK2
#
# Task 2 - NIM Game
#
# Author: Niels 'PerlBoy' van Dijke
#

use v5.16;
use strict;
use warnings;

use Term::ReadKey;
use Time::HiRes qw(usleep);
use POSIX qw(ceil);

my $tokens = 12;

my @players = qw(human machine);

my $currentPlayer = int(rand(2));

while ($tokens > 0) {
  my @validPicks = (1 .. ($tokens <= 3 ? $tokens : 3));
  my $validPickRE = sprintf('^[%s]$', join('', @validPicks));
  my $defaultPick = $validPicks[-1];
  my $takeTokens;

  if ($players[$currentPlayer] eq 'human') {

     printf "[H] Tokens left: %d, please enter number of tokens (%s) [%d]: ", 
            $tokens, join(',', @validPicks), $defaultPick;

     ReadMode('cbreak');

     do {
       $takeTokens = ReadKey(-1);
       if (!defined $takeTokens) {
         usleep(1_000);
       } elsif (uc($takeTokens) eq 'Q') {
         # Give up, you loose
         print "Quit\n\n>>> You loose <<<\n";
         exit;
       } elsif ($takeTokens =~ m#^[\r\n]$#) {
         $takeTokens = $defaultPick;
       } elsif ($takeTokens !~ m#$validPickRE# or 
                !grep {$takeTokens == $_} @validPicks) {
         undef($takeTokens);
       }
     } while (!defined $takeTokens);

     ReadMode('restore');

     print "$takeTokens\n";

     $tokens -= $takeTokens;

     if ($tokens == 0) {
       print "\n>>> You win <<<\n";
     }

  } else {

     my %tStrategy = (
       1 => 1, 2 => 2, 3 => 3,
       4 => 1, 5 => 1, 6 => 2,
       7 => 3, 8 => 2, 9 => 3
     );

     $takeTokens = $tStrategy{$tokens} // ceil(rand(@validPicks));

     printf "[M] Tokens left: %d, I'll take: %d\n", $tokens, $takeTokens;

     $tokens -= $takeTokens;

     if ($tokens == 0) {
       print "\n>>> I win <<<\n";
     }
  }

  $currentPlayer = ($currentPlayer + 1 ) % 2;
}


END {
  ReadMode('restore');
}
