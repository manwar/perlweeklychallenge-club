#!/usr/bin/env perl

# Task 1: Sort Language
# Submitted by: Mohammad S Anwar
# 
# You are given two array of languages and its popularity.
# Write a script to sort the language based on popularity.
#
# Example 1
# Input: @lang = ('perl', 'c', 'python')
#        @popularity = (2, 1, 3)
# Output: ('c', 'perl', 'python')
# 
# Example 2
# Input: @lang = ('c++', 'haskell', 'java')
#        @popularity = (1, 3, 2)
# Output: ('c++', 'java', 'haskell')


use strict;
use warnings;
use Data::Dumper;


my @lang = ('perl', 'c', 'python');
my @popularity = (2, 1, 3);
order_lang(\@lang, \@popularity);

@lang = ('c++', 'haskell', 'java');
@popularity = (1, 3, 2);
order_lang(\@lang, \@popularity);

@lang = ('c++', 'haskell', 'java', 'perl', 'c', 'python');
@popularity = (1, 3, 2, 2, 1, 3);
order_lang(\@lang, \@popularity);

exit 0;

sub order_lang {
    my $lang = shift;
    my $popularity = shift;

    my %lang;
    foreach my $i (0..$#lang) {
        push @{ $lang{ $popularity[$i] } }, $lang[$i];
    }

    printf "language based on popularity: (%s)\n",
        join ', ', map { join ', ',  @{ $lang{$_} } }
                    sort { $a <=> $b } keys %lang;
}
