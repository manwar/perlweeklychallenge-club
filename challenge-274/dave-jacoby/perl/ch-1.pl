#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

use List::Util qw{max};

my @examples = (

    "I love Perl",
    "Perl and Raku are friends",
    "The Weekly Challenge",
);

for my $example (@examples) {
    my $output = goat_latin($example);
    say <<"END";
    Input:  \$sentence = "$example"
    Output: "$output"
END
}

sub goat_latin ($sentence) {
    my @output;
    my @words  = split /\W/, $sentence;
    my @vowels = qw{ a e i o u };
    my $c      = 0;
    for my $word (@words) {
        my $newword;
        $c++;
        my $first_letter = substr $word, 0, 1;
        if ( grep { /$first_letter/mix } @vowels ) {
            $newword = $word;
        }
        else {
            $newword = $word;
            substr( $newword, 0, 1 ) = '';
            $newword .= $first_letter;
        }
        $newword .= 'ma';
        $newword .= 'a' x $c;
        push @output, $newword;
    }
    return join ' ', @output;
}
