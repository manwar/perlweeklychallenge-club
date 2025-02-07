#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ first };

my @examples = (

    [ "acca", "dog",  "god",  "perl", "repl" ],
    [ "abba", "baba", "aabb", "ab",   "ab" ],
);

for my $example (@examples) {
    my $words  = join ', ', map {qq{"$_"}} $example->@*;
    my $output = find_anagrams( $example->@* );
    say <<"END";
    Input:  \@words = ($words)
    Output: $output
END
}

sub find_anagrams(@words) {
    for my $i ( 0 .. $#words ) {
        next unless defined $words[$i];
        my $w = $words[$i];
        my $x = join '', sort split //, $w;
        for my $j ( $i+1 .. $#words ) { 
            my $y = join '', sort split //, $words[$j];
            next unless $x eq $y;
            $words[$j] = undef;
        }
    }
    @words = grep { defined } @words;
    return scalar @words;
}
