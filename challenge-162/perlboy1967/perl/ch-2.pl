#!/bin/perl

=pod

The Weekly Challenge - 162
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-162/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Wheatstone-Playfair
Submitted by: Roger Bell_West

Implement encryption and decryption using the Wheatstone-Playfair cipher.

=cut

use v5.16;

use constant WP_ENCRYPT => 1;
use constant WP_DECRYPT => -1;

use Test::More;

is(encrypt('playfair example', 'hide the gold in the tree stump'), 'bmodzbxdnabekudmuixmmouvif');
is(decrypt('perl and raku', 'siderwrdulfipaarkcrw'), 'thewexeklychallengex');

done_testing();


sub encrypt ($$) {
  _wpCrypt($_[0],$_[1],WP_ENCRYPT);
}


sub decrypt ($$) {
  _wpCrypt($_[0],$_[1],WP_DECRYPT);
}


sub _wpCrypt ($$$) {
  my ($key,$text,$mode) = (lc $_[0], lc $_[1], $_[2]);

  my ($hrC2L,$arL2C,@return);

  # Remove spaces from key
  $key =~ s/\s//g;

  my @keyChars = split//,$key;
  my %chars = map { $_ => 1 } ('a' .. 'z');
  my %usedChars;

  # Build encryption matrix
  for my $row (0..4) {
    for my $col (0..4) {
      my $char;
      do {
        $char = (scalar @keyChars ? shift @keyChars : (sort keys %chars)[0]);
        delete $chars{$char};
        delete $chars{j} if $char eq 'i';
        delete $chars{i} if $char eq 'j';
      } while (exists $usedChars{$char});
      $hrC2L->{$char} = [$row,$col];
      $arL2C->[$row][$col] = $char;
      $usedChars{$char} = 1;
      $usedChars{j} = 1 if $char eq 'i';
      $usedChars{i} = 1 if $char eq 'j';
    }
  }

  # Remove spaces from text
  $text =~ s/\s//g;

  # On ecryption, insert 'x' before repeating characters
  $text =~ s/(.)(?=\1)/$1x/g
    if $mode == WP_ENCRYPT;

  # Process per 2 chars of plaintext
  while ($text =~ s#^(.)(.)?##c) {
    my ($char1,$char2) = ($1, $2 // 'x');

    my ($c1,$c2) = ($hrC2L->{$char1},$hrC2L->{$char2});

    # Coords form rectangle?
    if ($c1->[0] != $c2->[0] and $c1->[1] != $c2->[1]) {
      push(@return,$arL2C->[$c1->[0]][$c2->[1]]);
      push(@return,$arL2C->[$c2->[0]][$c1->[1]]);
    } elsif ($c1->[0] == $c2->[0]) {
      # row
      push(@return,$arL2C->[$c1->[0]][($c1->[1]+$mode)%5]);
      push(@return,$arL2C->[$c2->[0]][($c2->[1]+$mode)%5]);
    } else {
      # column
      push(@return,$arL2C->[($c1->[0]+$mode)%5][$c1->[1]]);
      push(@return,$arL2C->[($c2->[0]+$mode)%5][$c2->[1]]);
    }
  } 

  return join('',@return);
}


