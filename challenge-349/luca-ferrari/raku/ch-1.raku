#!raku

#
# Perl Weekly Challenge 349
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-349>
#

sub MAIN( Str $string ) {

    my %powers;
    for $string.comb -> $l {
	%powers{ ( $string ~~ / $l+ / ).Str.chars } = $l;
    }

    %power.keys.max.say;
    #(%powers{ %powers.keys.max } xx %powers.keys.max).join.say;
}
