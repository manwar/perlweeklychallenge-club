#!/usr/bin/perl

use strict;
use warnings;

my $string = "perlweeklychallenge";
my $words  = [ "weekly", "challenge", "perl" ];
my $match  = word_break($string, $words);

(@$match)
?
(print sprintf("Matched: %s\n", join (", ", @$match)))
:
(print "None matched.\n");

sub word_break {
    my ($string, $words) = @_;

    return [ grep { $string =~ /$_/i } @$words ];
}
