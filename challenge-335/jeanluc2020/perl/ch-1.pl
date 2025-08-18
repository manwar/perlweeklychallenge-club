#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-335/#TASK1
#
# Task 1: Common Characters
# =========================
#
# You are given an array of words.
#
# Write a script to return all characters that is in every word in the given array including duplicates.
#
## Example 1
##
## Input: @words = ("bella", "label", "roller")
## Output: ("e", "l", "l")
#
#
## Example 2
##
## Input: @words = ("cool", "lock", "cook")
## Output: ("c", "o")
#
#
## Example 3
##
## Input: @words = ("hello", "world", "pole")
## Output: ("l", "o")
#
#
## Example 4
##
## Input: @words = ("abc", "def", "ghi")
## Output: ()
#
#
## Example 5
##
## Input: @words = ("aab", "aac", "aaa")
## Output: ("a", "a")
#
############################################################
##
## discussion
##
############################################################
#
# We do this one in multiple passes:
# 1. split each word into its characters and count how often each character
#    appears in it
# 2. initialize an output data hash with the first hash from the resulting
#    array
# 3. for each each character in the keys of that hash and for each hash in the
#    array, check whether the character appears in the hash. If it doesn't,
#    remove it from the output data hash. If it does, set the corresponding
#    value in the data output hash to the minimum of the two current values
# 4. collect the remaining characters and the number of their occurrences to
#    create the output array

use v5.36;

common_characters("bella", "label", "roller");
common_characters("cool", "lock", "cook");
common_characters("hello", "world", "pole");
common_characters("abc", "def", "ghi");
common_characters("aab", "aac", "aaa");

sub common_characters( @words ) {
    say "Input: (\"" . join("\", \"", @words) . "\")";
    my @data = ();
    foreach my $word (@words) {
        my $tmp = {};
        foreach my $char (split //, $word) {
            $tmp->{$char}++;
        }
        push @data, $tmp;
    }
    my $output = { %{$data[0]} };
    foreach my $hash (@data) {
        foreach my $char (keys %$output) {
            if($hash->{$char}) {
                $output->{$char} = $hash->{$char} if $hash->{$char} < $output->{$char};
            } else {
                delete $output->{$char};
            }
        }
    }
    my @out = ();
    foreach my $char (keys %$output) {
        foreach my $count (1..$output->{$char}) {
            push @out, $char;
        }
    }
    say "Output: (" . join(", ", map {"\"$_\""} @out) . ")";
}
