#!raku

#
# Perl Weekly Challenge 225
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-225/>
#

sub MAIN( *@numbers where { @numbers.grep( * ~~ Int ).elems == @numbers.elems } ) {
    my ( @left, @right );

    @left.push: 0;
    @left.push: @numbers[ 0 .. $_ ].sum for 0 ..^ @numbers.elems - 1;

    @right.push: @numbers[ $_ .. * ].sum for 1 ..^ @numbers.elems;
    @right.push: 0;

    say @left;
    say @right;

    (@left Z[-] @right).map( { $_.abs } ).say;
}
