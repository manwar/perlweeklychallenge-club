#!/usr/bin/env perl

# Perl Weekly Challenge 254 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/

use Modern::Perl;

my $word = shift || "";
my @vowels;
$word =~ s/[aeiou]/ push @vowels, $&; $& /gei;
$word =~ s/[aeiou]/ pop @vowels /gei;
$word =~ s/(.)(.*)/ uc($1).lc($2) /e;
say $word;
