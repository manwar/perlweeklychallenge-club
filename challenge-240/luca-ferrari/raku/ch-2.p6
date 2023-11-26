#!raku

#
# Perl Weekly Challenge 240
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-240/>
#
# Write a script to create an array such that new[i] = old[old[i]] where 0 <= i < new.length.
sub MAIN( *@numbers where { @numbers.grep( * ~~ Int ).elems == @numbers.elems } ) {
    my @new;
    @new[ $_ ] = @numbers[ @numbers[ $_ ] ] for 0 ..^ @numbers.elems;
    @new.join( ', ' ).say;
}
