#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-287>

Author: Niels 'PerlBoy' van Dijke

Task 1: Strong Password
Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a program to return the minimum number of steps required to make the given string very strong password.
If it is already strong then return 0.

Criteria:

- It must have at least 6 characters.
- It must contains at least one lowercase letter, at least one upper case letter and at least one digit.
- It shouldn't contain 3 repeating characters in a row.

Following can be considered as one step:

- Insert one character
- Delete one character
- Replace one character with another

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use List::Util qw(max);
use List::MoreUtils qw(all none arrayify indexes);

sub isStrongPassword :prototype($$\@\@) ($password,$minLength,$arAll,$arNone) {
    (length($password) >= $minLength) && 
    (all  { $password =~ /$_/ } @$arAll) && 
    (none { $password =~ /$_/ } @$arNone)
}

sub stepsToMakeStrongPassword ($password) {
  my $minLength = 6;
  my @all = (['a'..'z'],['A'..'Z'],['0'..'9']);
  my @allRe = map { sprintf('[%s-%s]',$$_[0],$$_[-1]) } @all;
  my @noneRe = (qr/(.)\1\1/);

  return 0 if isStrongPassword($password,$minLength,@allRe,@noneRe); 

  my $steps = 0;
  do {
    # Get usable character class indexes for next iteration
    my @availC = indexes { $password !~ /$_/ } @allRe;
    @availC = (0 .. $#allRe) unless @availC;

    # Get preferred characters to use first (to comply to 'all')
    my @p = arrayify map { $all[$_] } @availC;

    # Get avaiable characters for next iteration
    my %f = map { $_ => 0 } @p;
    $f{$_}++ for (split //,$password);
    my @a = grep { $f{$_} == 0 } sort keys %f;

    # Get random character to be used
    my $rChr = $a[rand @a];

    # Replace last character in 3 identical character sequence?
    if ($password !~ s/(.)\1\1/$1$1$rChr/) {
      # No, do other checks
      if (length($password) >= $minLength) {
        # Replace max occuring character
        my $m = max(values %f);
        my $r = (grep { $f{$_} == $m } keys %f)[0]; 
        $password =~ s/$r/$a[rand @a]/e;
      } else {
        # Extend the password with one character
        $password .= $rChr;
      }
    }

    $steps++;
  } while not(isStrongPassword($password,$minLength,@allRe,@noneRe));

  return $steps;
}

for (['a',5],['aB2',3],['PaasWS0rd',0],['PaaasWS0rd',1],['aaaaa',2]) {
  is(stepsToMakeStrongPassword($$_[0]),$$_[1],$$_[0]);
}

done_testing;


