#!raku

#
# Perl Weekly Challenge 309
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-309>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    my %gaps;
    for 1 ..^ @nums.elems {
	%gaps{ @nums[ $_ ] - @nums[ $_ - 1 ] } = @nums[ $_ ];
    }

    %gaps{ %gaps.keys.min }.say;
}
