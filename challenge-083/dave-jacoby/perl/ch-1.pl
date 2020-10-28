#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

for my $string (
    "the weekly challenge",
    "the purpose of our lives is to be happy",
    "the life of the land is perpetuated in righteousness",
    "there's more than one way to do it",
    " this is a test "
    )
{
    words_length($string);
}

sub words_length ( $string ) {
    $string =~ s/^\s|\s$//gmix;
    my @string = split /\s+/, $string;
    pop @string; shift @string;
    my $newstring = join '', @string;
    say $string;
    say length $newstring;
    say '';
}
