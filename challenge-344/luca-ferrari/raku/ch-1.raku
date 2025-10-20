#!raku

#
# Perl Weekly Challenge 344
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-344>
#

sub MAIN( Int $x, *@numbers where { @numbers.grep( * ~~ Int ).elems == @numbers.elems } ) {
    my @n = $x.comb;
    @n.unshift: 0  while ( @n.elems < @numbers.elems );

    say @numbers <<+>> @n;
}
