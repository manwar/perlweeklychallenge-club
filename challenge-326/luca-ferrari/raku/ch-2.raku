#!raku

#
# Perl Weekly Challenge 326
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-326>
#

sub MAIN( *@nums where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    my @result;
    for @nums -> $base, $times {
	@result.push: ( $base xx $times );
    }

    @result.flat.say;
}
