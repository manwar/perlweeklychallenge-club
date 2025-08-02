#!raku

#
# Perl Weekly Challenge 278
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-278>
#

sub MAIN( *@words ) {
    my %phrase;
    for @words {
	/ ^ (<[a..zA..Z]>+) (\d) $ /;
	%phrase{ $/[ 1 ] } = $/[ 0 ].Str;
    }

    %phrase.sort.map( { .value } ).join( ' ' ).say;
}
