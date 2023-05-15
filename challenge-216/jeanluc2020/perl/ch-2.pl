#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-216/#TASK2
#
# Task 2: Word Stickers
# =====================
#
# You are given a list of word stickers and a target word.
#
# Write a script to find out how many word stickers is needed to make up the
# given target word.
#
## Example 1:
##
## Input: @stickers = ('perl','raku','python'), $word = 'peon'
## Output: 2
##
## We just need 2 stickers i.e. 'perl' and 'python'.
## 'pe' from 'perl' and
## 'on' from 'python' to get the target word.
#
## Example 2:
##
## Input: @stickers = ('love','hate','angry'), $word = 'goat'
## Output: 3
##
## We need 3 stickers i.e. 'angry', 'love' and 'hate'.
## 'g' from 'angry'
## 'o' from 'love' and
## 'at' from 'hate' to get the target word.
#
## Example 3:
##
## Input: @stickers = ('come','nation','delta'), $word = 'accommodation'
## Output: 4
##
## We just need 2 stickers of 'come' and one each of 'nation' & 'delta'.
## 'a' from 'delta'
## 'ccommo' from 2 stickers 'come'
## 'd' from the same sticker 'delta' and
## 'ation' from 'nation' to get the target word.
#
## Example 4:
##
## Input: @stickers = ('come','country','delta'), $word = 'accommodation'
## Output: 0
##
## as there's no "i" in the inputs.
#
############################################################
##
## discussion
##
############################################################
#
# This one looks a bit more complicated, but it's basically
# a lot of helper functions so we have a bit of a not too
# complicated flow.
# We split the word into its characters. The result is a hash
# that uses the characters as the key and the number of
# occurences of this character as the value. We later split
# the stickers the same way. That helps to better match the
# characters on each sticker with the characters of the word.
#
# We use the "get_output()" function to calculate the output
# for a split word and the split stickers. This is a recursive
# function that will call itself with the remaining parts of
# the word and the split stickers. That way we can calculate
# the minimum solution by calculating all possible solutions
# and keeping the minimum. So if the word is "nice", and the
# stickers are "on", "ice", and "nice" this doesn't use the
# two stickers "on" and "ice" for the solution, but the single
# "nice" one.

use strict;
use warnings;

word_stickers('peon', 'perl','raku','python');
word_stickers('goat', 'love','hate','angry');
word_stickers('accommodation', 'come','nation','delta');
word_stickers('accommodation', 'come','country','delta');
word_stickers('nice', 'on','ice','nice'); # this should return 1, not 2

sub word_stickers {
   my ($word, @stickers) = @_;
   print "Input: (" . join(",", @stickers) . ") - $word\n";
   # we split the word
   my $word_characters = split_a_word($word);
   # now we split the stickers and keep the results in a single
   # hash that uses the sticker as the key and the split (a hash
   # reference) as the value
   my $sticker_splits = {};
   foreach my $sticker (@stickers) {
      $sticker_splits->{$sticker} = split_a_word($sticker);
   }
   # now we just call the recursive function
   my $output = get_output($sticker_splits, $word_characters);
   print "Output: $output\n";
}

sub get_output {
   my ($sticker_splits, $word_characters) = @_;
   my $output = 0;
   # if any of the characters of the word doesn't exist in the stickers, we
   # can only return 0 as there is no solution
   return $output unless all_chars_in_splits($word_characters, $sticker_splits);
   my $minimum = 0;
   # calculate all possible solutions by checking each single sticker, and if
   # any of the characters in the word is in the sticker, create a copy of the word
   # hash (to not overwrite the hash for the next round), the remove all characters
   # from the word hash that are in the sticker and recursively call get_output()
   # again to calculate the rest.
   foreach my $sticker (keys(%$sticker_splits)) {
      my $current = 0;
      if(any_char_in_sticker($word_characters, $sticker_splits->{$sticker})) {
         my $tmp_characters = deep_copy($word_characters);
         $current = 1;
         foreach my $key (keys(%{$sticker_splits->{$sticker}})) {
            $tmp_characters->{$key} -= $sticker_splits->{$sticker}->{$key};
            delete $tmp_characters->{$key} if $tmp_characters->{$key} <= 0;
         }
         $current += get_output($sticker_splits, $tmp_characters);
         $minimum = $current if $current < $minimum or $minimum == 0;
      }
   }
   return $minimum;
}

# checks if any of the characters in the word are in the sticker
sub any_char_in_sticker {
   my ($word_characters, $sticker_characters) = @_;
   foreach my $char (%$word_characters) {
      return 1 if $sticker_characters->{$char};
   }
   return 0;
}

# create a deep copy of a hash that is given by reference
sub deep_copy {
   my $hash = shift;
   return undef unless ref($hash) eq "HASH";
   my $result = {};
   foreach my $key (keys(%$hash)) {
      $result->{$key} = $hash->{$key};
   }
   return $result;
}

# check if all characters from a word are in the stickers
sub all_chars_in_splits {
   my ($word_characters, $sticker_splits) = @_;
   foreach my $char (keys(%$word_characters)) {
      my $found = 0;
      WORD: foreach my $w (keys(%$sticker_splits)) {
         foreach my $c (keys(%{$sticker_splits->{$w}})) {
            if($c eq $char) {
               $found = 1;
               last WORD;
            }
         }
      }
      # if we didn't find the current character we can return 0
      return 0 unless $found;
   }
   # since we found all characters in at least one of the stickers
   # we can return 1
   return 1;
}


# split a word into its characters and return a hash that has
# the characters as keys. The value is the amount of times each
# character was found in the word
sub split_a_word {
   my $word = shift;
   my @chars = split //, $word;
   my $result;
   foreach my $c (@chars) {
      $result->{$c}++;
   }
   return $result;
}

