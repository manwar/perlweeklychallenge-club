#!/bin/perl

=pod

The Weekly Challenge - 278
- https://theweeklychallenge.org/blog/perl-weekly-challenge-278

Author: Niels 'PerlBoy' van Dijke

Task 2: Reverse Word
Submitted by: Mohammad Sajid Anwar

You are given a word, $word and a character, $char.

Write a script to replace the substring up to and including $char with
its characters sorted alphabetically. If the $char doesn’t exist then
DON'T do anything.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

sub reverseWord ($word,$char) {
  $word =~ s#^(.*?$char)#join('',sort split //,$1)#er;
}

is(reverseWord('challenge','e'),'acehllnge');
is(reverseWord('programming','a'),'agoprrmming');
is(reverseWord('champion','b'),'champion');

done_testing;
