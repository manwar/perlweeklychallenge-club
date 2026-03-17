#!/usr/bin/env perl

use Modern::Perl;

my $word = shift || "";
my @vowels;
$word =~ s/[aeiou]/ push @vowels, $&; $& /gei;
$word =~ s/[aeiou]/ pop @vowels /gei;
$word =~ s/(.)(.*)/ uc($1).lc($2) /e;
say $word;
