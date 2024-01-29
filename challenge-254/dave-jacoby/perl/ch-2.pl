#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ max sum0 };

my @examples = ( "Raku", "Perl", "Julia", "Uiua", "Dave", 'signatures' );

for my $example (@examples) {
    my $output = reverse_vowels($example);

    say <<~"END";
    Input:  \$s = "$example"
    Output: "$output"
    END
}

sub reverse_vowels ($string) {
    my @vowels =
        reverse
        map  { lc }
        grep { /[aeiou]/mix }
        split //, $string;
    for my $i ( 0 .. -1 + length $string ) {
        my $c = substr( $string, $i, 1 );
        my $v = $c =~ /[aeiou]/mix ? 1 : 0;
        if ( $c =~ /[aeiou]/mix ) {
            my $n = shift @vowels;
            $n = uc $n if $c eq uc $c;
            substr( $string, $i, 1 ) = $n;
        }
    }

    return $string;
}
