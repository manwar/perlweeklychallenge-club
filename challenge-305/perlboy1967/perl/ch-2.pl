#!/bin/perl

=pod

The Weekly Challenge - 305
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-305#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 2: Alien Dictionary
Submitted by: Mohammad Sajid Anwar

You are given a list of words and alien dictionary character order.

Write a script to sort lexicographically the given list of words based on the alien
dictionary characters.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

no warnings qw(experimental::signatures);

sub alienDictionary :prototype(\@\@) ($arWords,$arAlien) {
  my $alien = join('',@$arAlien);
  [
    sort { 
      eval "\$a =~ tr/abcdefghijklmnopqrstuvwxyz/$alien/r"
      cmp
      eval "\$b =~ tr/abcdefghijklmnopqrstuvwxyz/$alien/r";
    } @$arWords
  ]
}

is(alienDictionary(@{[qw(perl python raku)]},
                   @{[qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/]}),
                     [qw(raku python perl)],'Example 1');
is(alienDictionary(@{[qw(the weekly challenge)]},
                   @{[qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/]}),
                     [qw(challenge the weekly)],'Example 2');

done_testing;
