#!raku

#
# Perl Weekly Challenge 322
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-322>
#

sub MAIN( *@numbers where { @numbers.grep( * ~~ Int ).elems == @numbers.elems } ) {
    my @result;
    for @numbers -> $current {
	@result.push: @numbers.sort.grep( * ~~ $current, :k ).first + 1;
    }

    @result.say;
}
