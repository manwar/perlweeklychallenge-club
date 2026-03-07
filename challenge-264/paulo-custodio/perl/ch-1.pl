#!/usr/bin/env perl

use Modern::Perl;

say greatest_letter(shift // '');

sub greatest_letter {
    my($word) = @_;
    for my $upper (reverse 'A' .. 'Z') {
        my $lower = lc($upper);
        return $upper if $word =~ /$upper/ && $word =~ /$lower/;
    }
    return "''";
}
